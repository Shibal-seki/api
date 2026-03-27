#!/bin/bash

API="https://monitoring-app.on-forge.com/api/v1"
TOKEN=""

# ---------- LOGIN ----------
login() {
    read -p "Email: " email
    read -s -p "Password: " password
    echo ""

    res=$(curl -s -X POST "$API/auth/login" \
        -H "Content-Type: application/json" \
        -d "{\"email\":\"$email\",\"password\":\"$password\"}")

    TOKEN=$(echo $res | jq -r '.data.token')

    [ "$TOKEN" = "null" ] && echo "❌ Erreur login" || echo "✅ Connecté"
}

# ---------- GROUPES ----------
list_groups() {
    curl -s -H "Authorization: Bearer $TOKEN" "$API/application-groups" |
        jq -r '.data[] | "\(.id) | \(.name) | \(.description)"' |
        column -t -s "|"
}

get_group() {
    read -p "ID: " id
    curl -s -H "Authorization: Bearer $TOKEN" "$API/application-groups/$id" | jq
}

create_group() {
    read -p "Nom: " name
    read -p "Description: " desc

    curl -s -X POST "$API/application-groups" \
        -H "Authorization: Bearer $TOKEN" \
        -H "Content-Type: application/json" \
        -d "{\"name\":\"$name\",\"description\":\"$desc\"}" | jq
}

update_group() {
    read -p "ID: " id
    read -p "Nom: " name
    read -p "Description: " desc

    curl -s -X PUT "$API/application-groups/$id" \
        -H "Authorization: Bearer $TOKEN" \
        -H "Content-Type: application/json" \
        -d "{\"name\":\"$name\",\"description\":\"$desc\"}" | jq
}

delete_group() {
    read -p "ID: " id
    read -p "Confirmer (o/n): " c

    [ "$c" = "o" ] && curl -s -X DELETE "$API/application-groups/$id" \
        -H "Authorization: Bearer $TOKEN" && echo "✅ Groupe supprimé" || echo "❌ Annulé"
}

# ---------- APPLICATIONS ----------
list_apps() {
    curl -s -H "Authorization: Bearer $TOKEN" "$API/applications" |
        jq -r '.data[] | "\(.id) | \(.name) | \(.url)"' |
        column -t -s "|"
}

get_app() {
    read -p "ID: " id
    curl -s -H "Authorization: Bearer $TOKEN" "$API/applications/$id" | jq
}

create_app() {
    read -p "Nom: " name
    read -p "URL: " url
    read -p "Description: " desc

    curl -s -X POST "$API/applications" \
        -H "Authorization: Bearer $TOKEN" \
        -H "Content-Type: application/json" \
        -d "{\"name\":\"$name\",\"url\":\"$url\",\"description\":\"$desc\",\"monitoring_enabled\":true}" | jq
}

update_app() {
    read -p "ID: " id
    read -p "Nom: " name
    read -p "URL: " url
    read -p "Description: " desc

    curl -s -X PUT "$API/applications/$id" \
        -H "Authorization: Bearer $TOKEN" \
        -H "Content-Type: application/json" \
        -d "{\"name\":\"$name\",\"url\":\"$url\",\"description\":\"$desc\",\"monitoring_enabled\":true}" | jq
}

delete_app() {
    read -p "ID: " id
    read -p "Confirmer (o/n): " c

    [ "$c" = "o" ] && curl -s -X DELETE "$API/applications/$id" \
        -H "Authorization: Bearer $TOKEN" && echo "✅ Application supprimée" || echo "❌ Annulé"
}

# ---------- INCIDENTS ----------
list_incidents() {
    curl -s -H "Authorization: Bearer $TOKEN" "$API/incidents" |
        jq -r '.data[] | "\(.id) | \(.title) | \(.status) | \(.severity)"' |
        column -t -s "|"
}

get_incident() {
    read -p "ID: " id
    curl -s -H "Authorization: Bearer $TOKEN" "$API/incidents/$id" | jq
}

create_incident() {
    read -p "Titre: " t
    read -p "Description: " d
    read -p "App ID: " app
    read -p "Severity (LOW/HIGH/CRITICAL): " s

    now=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

    curl -s -X POST "$API/incidents" \
        -H "Authorization: Bearer $TOKEN" \
        -H "Content-Type: application/json" \
        -d "{\"title\":\"$t\",\"description\":\"$d\",\"application_id\":\"$app\",\"status\":\"OPEN\",\"severity\":\"$s\",\"started_at\":\"$now\"}" | jq
}

update_incident() {
    read -p "ID: " id
    read -p "Titre: " t
    read -p "Description: " d
    read -p "Status (OPEN/IN_PROGRESS/RESOLVED/CLOSED): " st
    read -p "Severity (LOW/HIGH/CRITICAL): " s

    curl -s -X PUT "$API/incidents/$id" \
        -H "Authorization: Bearer $TOKEN" \
        -H "Content-Type: application/json" \
        -d "{\"title\":\"$t\",\"description\":\"$d\",\"status\":\"$st\",\"severity\":\"$s\"}" | jq
}

delete_incident() {
    read -p "ID: " id
    read -p "Confirmer (o/n): " c

    [ "$c" = "o" ] && curl -s -X DELETE "$API/incidents/$id" \
        -H "Authorization: Bearer $TOKEN" && echo "✅ Incident supprimé" || echo "❌ Annulé"
}

resolve_incident() {
    read -p "ID: " id
    curl -s -X PUT "$API/incidents/$id/resolve" \
        -H "Authorization: Bearer $TOKEN" | jq
}

reopen_incident() {
    read -p "ID: " id
    curl -s -X PUT "$API/incidents/$id/reopen" \
        -H "Authorization: Bearer $TOKEN" | jq
}

# ---------- MENU ----------
while true; do
    echo ""
    echo "================================"
    echo "      🖥️  MonitoringApp CLI      "
    echo "================================"
    echo ""
    echo "--- 🔐 Connexion ---"
    echo "  1  Login"
    echo ""
    echo "--- 📦 Groupes ---"
    echo "  2  Lister les groupes"
    echo "  3  Voir un groupe"
    echo "  4  Créer un groupe"
    echo "  5  Modifier un groupe"
    echo "  6  Supprimer un groupe"
    echo ""
    echo "--- 🖥️  Applications ---"
    echo "  7  Lister les applications"
    echo "  8  Voir une application"
    echo "  9  Créer une application"
    echo "  10 Modifier une application"
    echo "  11 Supprimer une application"
    echo ""
    echo "--- 🚨 Incidents ---"
    echo "  12 Lister les incidents"
    echo "  13 Voir un incident"
    echo "  14 Créer un incident"
    echo "  15 Modifier un incident"
    echo "  16 Supprimer un incident"
    echo "  17 Résoudre un incident"
    echo "  18 Rouvrir un incident"
    echo ""
    echo "--- ❌ Quitter ---"
    echo "  0  Quitter"
    echo ""

    read -p "Choix: " c

    case $c in
        1)  login ;;
        2)  list_groups ;;
        3)  get_group ;;
        4)  create_group ;;
        5)  update_group ;;
        6)  delete_group ;;
        7)  list_apps ;;
        8)  get_app ;;
        9)  create_app ;;
        10) update_app ;;
        11) delete_app ;;
        12) list_incidents ;;
        13) get_incident ;;
        14) create_incident ;;
        15) update_incident ;;
        16) delete_incident ;;
        17) resolve_incident ;;
        18) reopen_incident ;;
        0)  echo "👋 Au revoir !" ; exit ;;
        *)  echo "❌ Option invalide" ;;
    esac

done
