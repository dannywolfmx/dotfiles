package main

import (
	"log"

	"github.com/dannywolfmx/dotfiles/prompt"
)

func main() {
	recipe, err := prompt.ReadRecipeFile("./recipe.yml")
	if err != nil {
		log.Fatal(err)
	}

	prompt.NewPrompt(recipe).Show()
}
