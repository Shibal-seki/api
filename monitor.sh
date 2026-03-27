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
          -H "Authorization: Bearer $TOKEN"
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
          -H "Authorization: Bearer $TOKEN"
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
          read -p "Status: " st
            read -p "Severity: " s

              curl -s -X PUT "$API/incidents/$id" \
                -H "Authorization: Bearer $TOKEN" \
                  -H "Content-Type: application/json" \
                    -d "{\"title\":\"$t\",\"description\":\"$d\",\"status\":\"$st\",\"severity\":\"$s\"}" | jq
}

delete_incident() {
    read -p "ID: " id
      read -p "Confirmer (o/n): " c

        [ "$c" = "o" ] && curl -s -X DELETE "$API/incidents/$id" \
          -H "Authorization: Bearer $TOKEN"
}

# ---------- MENU ----------
while true; do
echo ""
echo "================"
echo "===== MENU ====="
echo "================"
echo ""
echo "== Se connecter =="
echo ""
echo "1 Login"
echo ""
echo "===== Groupes ===="
echo ""
echo "2 List groupes"
echo "3 Voir groupe"
echo "4 Create groupe"
echo "5 Update groupe"
echo "6 Delete groupe"
echo ""
echo "===== Applications ===="
echo ""
echo "7 List apps"
echo "8 Voir app"
echo "9 Create app"
echo "10 Update app"
echo "11 Delete app"
echo ""
echo "===== Incidents ===="
echo ""
echo "12 List incidents"
echo "13 Voir incident"
echo "14 Create incident"
echo "15 Update incident"
echo "16 Delete incident"
echo ""
echo "== Quitter =="
echo ""
echo "0 Quit"
echo ""

read -p "Choix: " c

case $c in
1) login ;;
2) list_groups ;;
3) get_group ;;
4) create_group ;;
5) update_group ;;
6) delete_group ;;
7) list_apps ;;
8) get_app ;;
9) create_app ;;
10) update_app ;;
11) delete_app ;;
12) list_incidents ;;
13) get_incident ;;
14) create_incident ;;
15) update_incident ;;
16) delete_incident ;;
0) exit ;;
*) echo "Erreur" ;;
esac

done
}