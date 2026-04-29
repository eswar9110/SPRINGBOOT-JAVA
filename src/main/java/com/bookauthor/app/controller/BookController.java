package com.bookauthor.app.controller;

import com.bookauthor.app.model.Book;
import com.bookauthor.app.service.AuthorService;
import com.bookauthor.app.service.BookService;
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
 * Spring MVC Controller for Book entity.
 * Handles HTTP requests for listing, creating, updating books,
 * and displaying the inner join view.
 */
@Controller
@RequestMapping("/books")
public class BookController {

    private final BookService bookService;
    private final AuthorService authorService;

    @Autowired
    public BookController(BookService bookService, AuthorService authorService) {
        this.bookService = bookService;
        this.authorService = authorService;
    }

    /**
     * Display list of all books.
     */
    @GetMapping
    public String listBooks(Model model) {
        model.addAttribute("books", bookService.findAll());
        return "books/list";
    }

    /**
     * Show form to add a new book.
     */
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("book", new Book());
        model.addAttribute("authors", authorService.findAll());
        return "books/add";
    }

    /**
     * Handle form submission to create a new book.
     * Handles integrity violations (e.g., duplicate ISBN).
     */
    @PostMapping("/add")
    public String addBook(@Valid @ModelAttribute("book") Book book,
                          BindingResult result,
                          @RequestParam("authorId") Long authorId,
                          RedirectAttributes redirectAttributes,
                          Model model) {
        if (result.hasErrors()) {
            model.addAttribute("authors", authorService.findAll());
            return "books/add";
        }
        try {
            authorService.findById(authorId).ifPresent(book::setAuthor);
            bookService.save(book);
            redirectAttributes.addFlashAttribute("successMessage", "Book added successfully!");
            return "redirect:/books";
        } catch (DataIntegrityViolationException e) {
            model.addAttribute("authors", authorService.findAll());
            model.addAttribute("errorMessage",
                "Could not save book. ISBN may already exist. Please use a unique ISBN.");
            return "books/add";
        }
    }

    /**
     * Show form to edit an existing book.
     */
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model,
                               RedirectAttributes redirectAttributes) {
        Optional<Book> bookOpt = bookService.findById(id);
        if (!bookOpt.isPresent()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Book not found!");
            return "redirect:/books";
        }
        model.addAttribute("book", bookOpt.get());
        model.addAttribute("authors", authorService.findAll());
        return "books/edit";
    }

    /**
     * Handle form submission to update an existing book.
     */
    @PostMapping("/edit/{id}")
    public String updateBook(@PathVariable Long id,
                             @Valid @ModelAttribute("book") Book book,
                             BindingResult result,
                             @RequestParam("authorId") Long authorId,
                             RedirectAttributes redirectAttributes,
                             Model model) {
        if (result.hasErrors()) {
            book.setId(id);
            model.addAttribute("authors", authorService.findAll());
            return "books/edit";
        }
        try {
            authorService.findById(authorId).ifPresent(book::setAuthor);
            bookService.update(id, book);
            redirectAttributes.addFlashAttribute("successMessage", "Book updated successfully!");
            return "redirect:/books";
        } catch (DataIntegrityViolationException e) {
            book.setId(id);
            model.addAttribute("authors", authorService.findAll());
            model.addAttribute("errorMessage",
                "Could not update book. ISBN may already exist. Please use a unique ISBN.");
            return "books/edit";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/books";
        }
    }

    /**
     * Display the inner join view of Books and Authors.
     */
    @GetMapping("/join")
    public String showJoinView(Model model) {
        model.addAttribute("bookAuthors", bookService.getBooksWithAuthors());
        return "books/joinview";
    }
}
