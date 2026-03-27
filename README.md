# 🎤 Projet CLI MonitoringApp

## 🎯 Introduction

Bonjour,

Dans ce projet, j’ai développé un **client en ligne de commande (CLI)** en Bash pour interagir avec l’API REST de MonitoringApp.

L’objectif est de pouvoir **gérer les groupes, les applications et les incidents directement depuis le terminal**, sans passer par une interface web ou Postman.

---

## ⚙️ 1. Principe général

Mon script repose sur le principe des **API REST**.

Une API REST permet de communiquer avec un serveur via des requêtes HTTP :

- `GET` → récupérer des données  
- `POST` → créer  
- `PUT` → modifier  
- `DELETE` → supprimer  

Dans ce script, j’utilise la commande **curl** pour envoyer ces requêtes.

Les réponses sont en **JSON**, que je formate avec **jq** pour les rendre lisibles.

---

## 🔐 2. Authentification

La première étape est l’authentification.

L’utilisateur entre :
- son email  
- son mot de passe  

Le script envoie une requête :

```bash
POST /api/v1/auth/login
