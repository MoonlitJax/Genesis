package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	_ "github.com/lib/pq"
)

func main() {
	connStr := "postgres://admin:allfather_secure@db/allfather_data?sslmode=disable"
	db, err := sql.Open("postgres", connStr)
	if err != nil { log.Fatal(err) }

	http.HandleFunc("/ingest", func(w http.ResponseWriter, r *http.Request) {
		plate := r.URL.Query().Get("plate")
		lat := r.URL.Query().Get("lat")
		lon := r.URL.Query().Get("lon")

		query := `INSERT INTO vehicle_tracks (license_plate, latitude, longitude, geom) 
                  VALUES ($1, $2, $3, ST_SetSRID(ST_MakePoint($4, $5), 4326))`
		_, err := db.Exec(query, plate, lat, lon, lon, lat)
		
		if err != nil {
			http.Error(w, err.Error(), 500)
			return
		}
		fmt.Fprintf(w, "AllFather: Target %s Synced", plate)
	})

	fmt.Println("[GO] Neural Gateway active on :8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
