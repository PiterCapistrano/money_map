/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const functions = require("firebase-functions");
const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
//necessário ter o Firebase CLI instalado
const admin = require("firebase-admin");

//necessário fazer o npm install --save graphql-request
const request = require("graphql-request");

admin.initializeApp(functions.config().firebase);

const client = new request.GraphQLClient(
  "https://legible-firefly-59.hasura.app/v1/graphql",
  {
    headers: {
      "content-type": "application/json",
      "x-hasura-admin-secret":
        "NKoUwrd2dNCQZ41KPTqim2Kd3DZy67dVzhccC2E6Iwx4xzq0LiWpkqstvcjQNX5p",
    },
  }
);

//função que será chamada pelo cliente flutter
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

//após criar um usuário, essa função será executada e realizará alterações no banco de dados
exports.processSignUp = functions.auth.user().onCreate(async (user) => {
  const id = user.uid;
  const email = user.email;
  const name = user.displayName || "No Name";

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

    return data;
  } catch (error) {
    console.error("Error processing sign up:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Error processing sign up."
    );
  }
});

//em caso de remoção do usuário, essa função será executada e realizará a deleção do usuário no banco
exports.processDelete = functions.auth.user().onDelete(async (user) => {
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
