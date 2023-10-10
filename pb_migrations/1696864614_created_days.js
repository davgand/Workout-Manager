/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "4xov3p42psr3i0j",
    "created": "2023-10-09 15:16:54.247Z",
    "updated": "2023-10-09 15:16:54.247Z",
    "name": "days",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "x0cg1tif",
        "name": "description",
        "type": "text",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "min": null,
          "max": null,
          "pattern": ""
        }
      },
      {
        "system": false,
        "id": "w7chadam",
        "name": "exercises",
        "type": "relation",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "collectionId": "h0i3ynhu4su3k3n",
          "cascadeDelete": false,
          "minSelect": null,
          "maxSelect": null,
          "displayFields": null
        }
      }
    ],
    "indexes": [],
    "listRule": null,
    "viewRule": null,
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {}
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("4xov3p42psr3i0j");

  return dao.deleteCollection(collection);
})
