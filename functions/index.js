// Importação das funções e triggers do Firebase Functions v2
const functions = require("firebase-functions/v1");
const logger = require("firebase-functions/logger");
const admin = require("firebase-admin");
const request = require("graphql-request");

// Inicialização do Firebase Admin (sem a necessidade de passar config())
admin.initializeApp();

// Configuração do cliente GraphQL
const client = new request.GraphQLClient(
  "https://crisp-yak-15.hasura.app/v1/graphql",
  {
    headers: {
      "content-type": "application/json",
      "x-hasura-admin-secret":
        "OabgqfXj4syzFJ47s8ATuhc5Dy8n3eX8PMPYEtmGVSqAcPFSsBXhYZB6o6llKzXi",
    },
  }
);

// Função de registro do usuário
exports.registerUser = functions.https.onCall(async (data, context) => {
  const email = data.email;
  const password = data.password;
  const displayName = data.displayName;

  if (email == null || password == null || displayName == null) {
    throw new functions.https.HttpsError(
      "register-failed",
      "missing information"
    );
  }

  try {
    var userRecord = await admin.auth().createUser({
      email: email,
      password: password,
      displayName: displayName,
    });

    const customClaims = {
      "https://hasura.io/jwt/claims": {
        "x-hasura-default-role": "user",
        "x-hasura-allowed-roles": ["user"],
        "x-hasura-user-id": userRecord.uid,
      },
    };

    await admin.auth().setCustomUserClaims(userRecord.uid, customClaims);

    return userRecord.toJSON();
  } catch (error) {
    console.error("Error processing register:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Error processing register."
    );
  }
});

// Função de processamento do sign-up após criação do usuário
exports.processSignUp = functions.auth.user().onCreate(async (user) => {
  // Verificação explícita para garantir que o objeto 'user' esteja definido
  if (!user || !user.uid) {
    console.error("User object is undefined or malformed:", user);
    throw new Error("User object is undefined or malformed.");
  }

  const id = user.uid;
  const email = user.email;
  const name = user.displayName || "No Name";

  console.log("New user created:", { id, email, name });

  const mutation = `mutation($id: String!, $email: String, $name: String) {
        insert_user(objects: [{
            id: $id,
            email: $email,
            name: $name,
          }]) {
            affected_rows
          }
        }`;

  try {
    const data = await client.request(mutation, {
      id: id,
      email: email,
      name: name,
    });

    console.log("User inserted into Hasura:", data);

    return data;
  } catch (error) {
    console.error("Error processing sign up:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Error processing sign up."
    );
  }
});

// Função de deleção do usuário
exports.processDelete = functions.auth.user().onDelete(async (user) => {
  // Verificação explícita para garantir que o objeto 'user' esteja definido
  if (!user || !user.uid) {
    throw new Error("User object is undefined or malformed.");
  }

  const mutation = `mutation($id: String!) {
        delete_user(where: {id: {_eq: $id}}) {
          affected_rows
        }
    }`;

  const id = user.uid;

  try {
    const data = await client.request(mutation, {
      id: id,
    });
    return data;
  } catch (error) {
    console.error("Error processing delete:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Error processing delete."
    );
  }
});
