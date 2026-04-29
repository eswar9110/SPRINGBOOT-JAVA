package com.bookauthor.app.controller;

import com.bookauthor.app.model.Author;
import com.bookauthor.app.service.AuthorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.Optional;

/**
 * Spring MVC Controller for Author entity.
 * Handles HTTP requests for listing, creating, and updating authors.
 */
@Controller
@RequestMapping("/authors")
public class AuthorController {

    private final AuthorService authorService;

    @Autowired
    public AuthorController(AuthorService authorService) {
        this.authorService = authorService;
    }

    /**
     * Display list of all authors.
     */
    @GetMapping
    public String listAuthors(Model model) {
        model.addAttribute("authors", authorService.findAll());
        return "authors/list";
    }

    /**
     * Show form to add a new author.
     */
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("author", new Author());
        return "authors/add";
    }

    /**
     * Handle form submission to create a new author.
     * Handles integrity violations (e.g., duplicate email).
     */
    @PostMapping("/add")
    public String addAuthor(@Valid @ModelAttribute("author") Author author,
                            BindingResult result,
                            RedirectAttributes redirectAttributes,
                            Model model) {
        if (result.hasErrors()) {
            return "authors/add";
        }
        try {
            authorService.save(author);
            redirectAttributes.addFlashAttribute("successMessage", "Author added successfully!");
            return "redirect:/authors";
        } catch (DataIntegrityViolationException e) {
            model.addAttribute("errorMessage",
                "Could not save author. Email may already exist. Please use a unique email.");
            return "authors/add";
        }
    }

    /**
     * Show form to edit an existing author.
     */
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model,
                               RedirectAttributes redirectAttributes) {
        Optional<Author> authorOpt = authorService.findById(id);
        if (!authorOpt.isPresent()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Author not found!");
            return "redirect:/authors";
        }
        model.addAttribute("author", authorOpt.get());
        return "authors/edit";
    }

    /**
     * Handle form submission to update an existing author.
     */
    @PostMapping("/edit/{id}")
    public String updateAuthor(@PathVariable Long id,
                               @Valid @ModelAttribute("author") Author author,
                               BindingResult result,
                               RedirectAttributes redirectAttributes,
                               Model model) {
        if (result.hasErrors()) {
            author.setId(id);
            return "authors/edit";
        }
        try {
            authorService.update(id, author);
            redirectAttributes.addFlashAttribute("successMessage", "Author updated successfully!");
            return "redirect:/authors";
        } catch (DataIntegrityViolationException e) {
            author.setId(id);
            model.addAttribute("errorMessage",
                "Could not update author. Email may already exist. Please use a unique email.");
            return "authors/edit";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/authors";
        }
    }
}
