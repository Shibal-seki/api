# 🎤 Projet CLI MonitoringApp

## 🎯 Introduction

Bonjour,

Dans ce projet, j’ai développé un **client en ligne de commande (CLI)** en Bash pour interagir avec l’API REST de MonitoringApp.

L’objectif était de pouvoir **gérer les groupes, les applications et les incidents directement depuis le terminal**, sans passer par une interface web ou Postman.

---

## ⚙️ 🧠 1. Principe général

Mon script repose sur le principe des **API REST**.

Une API REST permet de communiquer avec un serveur via des requêtes HTTP comme :

- `GET` → récupérer des données  
- `POST` → créer  
- `PUT` → modifier  
- `DELETE` → supprimer  

Dans mon script, j’utilise la commande **curl** pour envoyer ces requêtes.

Les réponses sont en **JSON**, que je formate avec **jq** pour les rendre lisibles.

---

## 🔐 🔑 2. Authentification

La première étape est l’authentification.

L’utilisateur entre :

- son email  
- son mot de passe  

Le script envoie une requête POST vers :

```bash
---

## 🎯 INTRO (1 min)

Bonjour,
dans ce projet, j’ai développé un client en ligne de commande (CLI) en Bash pour interagir avec l’API REST de MonitoringApp.

L’objectif était de pouvoir gérer les groupes, les applications et les incidents directement depuis le terminal, sans passer par une interface web ou Postman.
---

## ⚙️ 🧠 1. PRINCIPE GÉNÉRAL (2 min)

Mon script repose sur le principe des API REST.

Une API REST permet de communiquer avec un serveur via des requêtes HTTP comme :

GET → récupérer des données
POST → créer
PUT → modifier
DELETE → supprimer

Dans mon script, j’utilise la commande curl pour envoyer ces requêtes.

Les réponses sont en JSON, que je formate avec jq pour les rendre lisibles.
---

## 🔐 🔑 2. AUTHENTIFICATION (2 min)

La première étape est l’authentification.

L’utilisateur entre :

son email
son mot de passe

Le script envoie une requête POST vers :

/api/v1/auth/login

Si les identifiants sont corrects, l’API renvoie un token JWT.

Ce token est stocké dans une variable appelée :

$TOKEN

Ensuite, ce token est utilisé dans toutes les requêtes avec l’en-tête :

Authorization: Bearer TOKEN

Cela permet de sécuriser les actions et d’identifier l’utilisateur.
---

## 🧱 📦 3. STRUCTURE DU SCRIPT (2 min)

Le script est organisé en plusieurs fonctions :

une fonction pour le login
des fonctions pour les groupes
des fonctions pour les applications
des fonctions pour les incidents

Chaque fonction correspond à un endpoint de l’API.

Par exemple :

list_groups() → GET groupes
create_group() → POST groupe
delete_group() → DELETE groupe

Cette structure rend le code plus lisible et modulaire.
---

## 📋 🎛️ 4. MENU INTERACTIF (1 min)

J’ai ajouté un menu interactif avec une boucle while.

L’utilisateur choisit une option :

1 → login
2 → lister les groupes
3 → créer un groupe
etc.

Ensuite, un case permet d’appeler la bonne fonction.

Cela rend l’outil simple à utiliser, même sans connaissances techniques.
---

## 📊 🔧 5. EXEMPLES D’ACTIONS (1.5 min)
✔️ Création d’un groupe

L’utilisateur saisit :

un nom
une description

Le script envoie une requête POST avec un JSON.

✔️ Liste des incidents

Une requête GET est envoyée, et les résultats sont affichés avec jq.

✔️ Suppression sécurisée

Avant de supprimer, le script demande :

"Êtes-vous sûr ? (o/n)"

Cela évite les erreurs.
---

## 🧠 💡 6. CHOIX TECHNIQUES (30 sec)

J’ai choisi Bash car :

il est léger
disponible sur Linux
adapté aux scripts CLI

J’ai volontairement simplifié le code pour le rendre :

lisible
pédagogique
facile à maintenir
---

## 🚧 ⚠️ 7. LIMITES / AMÉLIORATIONS (30 sec)

Le script pourrait être amélioré avec :

gestion des erreurs plus avancée
interface plus jolie (couleurs)
stockage du token dans un fichier
version PowerShell pour Windows
---

## 🎯 ✅ CONCLUSION (30 sec)

Pour conclure, ce projet m’a permis de comprendre :

le fonctionnement des API REST
l’authentification avec token
l’automatisation avec Bash

J’ai réussi à créer un outil fonctionnel permettant de gérer MonitoringApp entièrement en ligne de commande.
❓ C’est quoi un token ?

→ Une clé d’authentification temporaire

❓ Pourquoi API REST ?

→ Standard simple et utilisé partout
