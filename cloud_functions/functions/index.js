const functions = require('firebase-functions');
const admin = require('firebase-admin');
const algolia = require('algoliasearch');
admin.initializeApp(functions.config().firebase);
const db = admin.firestore();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });
// const ALGOLIA_ID = functions.config().algolia.app_id;
// const ALGOLIA_ADMIN_KEY = functions.config().algolia.api_key;
// const ALGOLIA_SEARCH_KEY = functions.config().algolia.search_key;

const client = algolia("VM7CMOP4D2", "21da3739f97cdb53dad68184e9fe6bdb");

const index = client.initIndex("records");

exports.recordToAlgolia = functions.region('europe-west3')
    .firestore.document('/records/{recordId}').onCreate(
        async (snapshot, context) => {
            var record = snapshot.data();
            record.objectID = context.params.recordId;
            await index.saveObject(record);
            console.log("Pushed record to Algolia:", record.title, record.body);
            return null;
        }
    );

exports.updateRecord = functions.region('europe-west3')
    .firestore.document('/records/{recordId}').onUpdate(
        async (change, context) => {
            var record = change.after.data();
            record.objectID = context.params.recordId;
            await index.saveObject(record);
            console.log("Updated record:", record.title, record.body);
            return null;
        }
    );

exports.deleteRecord = functions.region('europe-west3')
    .firestore.document('/records/{recordId}').onDelete(
        async (snapshot, context) => {
            await index.deleteObject(context.params.recordId);
            console.log("Deleted record:", context.params.recordId);
            return null;
        }
    );