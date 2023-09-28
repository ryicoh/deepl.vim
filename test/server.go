package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"log/slog"
	"net/http"
	"os"
)

var addrFlag = flag.String("addr", "127.0.0.1:8080", "http service address")

type (
	Translation struct {
		Text string `json:"text"`
	}

	TranslationResult struct {
		Translations []Translation `json:"translations"`
	}
)

func main() {

	http.HandleFunc("/v2/translate", func(w http.ResponseWriter, r *http.Request) {
		if err := r.ParseForm(); err != nil {
			http.Error(w, "failed to parse form", http.StatusBadRequest)
			return
		}

		if r.FormValue("auth_key") != "test_auth_key" {
			http.Error(w, "invalid auth key", http.StatusUnauthorized)
			return
		}

		text := r.FormValue("text")
		target := r.FormValue("target_lang")
		source := r.FormValue("source_lang")

		slog.Info("Request", slog.String("text", text), slog.String("source", source), slog.String("target", target))

		res := translate(text, source, target)

		body, err := json.Marshal(TranslationResult{Translations: []Translation{{res}}})

		if err != nil {
			http.Error(w, "Internal Server Error", http.StatusInternalServerError)
			return
		}

		slog.Info("Response", slog.String("text", res))

		w.Header().Set("Content-Type", "application/json")
		w.Write(body)
	})

	slog.Info("Server started at", slog.String("addr", *addrFlag))
	if err := http.ListenAndServe(*addrFlag, nil); err != nil {
		slog.Error("ListenAndServe:", err)
		os.Exit(1)
	}
}

var translations = map[string]map[string]map[string]string{
	"EN": {
		"JA": {
			"こんにちは": "Hello",
		},
	},
	"JA": {
		"EN": {
			"Getting started with \"Hello World\"": "\"Hello World\"を始めよう",
			"Getting started with `Hello World`":   "`Hello World`を始めよう",
		},
	},
}

func translate(text, source, target string) string {
	fmt.Println("text", text)
	return translations[target][source][text]
}
