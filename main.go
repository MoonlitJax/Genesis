package main
import (
    "fmt"
    "net/http"
)

func main() {
    http.HandleFunc("/ingest", func(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "AllFather: Signal Received")
    })
    fmt.Println("[GO] Neural Gateway active on :8080")
    http.ListenAndServe(":8080", nil)
}
