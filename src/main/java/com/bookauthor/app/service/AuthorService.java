package com.bookauthor.app.service;

import com.bookauthor.app.model.Author;
import com.bookauthor.app.repository.AuthorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

/**
 * Service class for Author entity.
 * Handles business logic and integrates with the AuthorRepository.
 */
@Service
public class AuthorService {

    private final AuthorRepository authorRepository;

    @Autowired
    public AuthorService(AuthorRepository authorRepository) {
        this.authorRepository = authorRepository;
    }

    /**
     * Retrieve all authors from the database.
     * @return List of all authors
     */
    public List<Author> findAll() {
        return authorRepository.findAll();
    }

    /**
     * Find an author by their ID.
     * @param id the author's ID
     * @return Optional containing the author if found
     */
    public Optional<Author> findById(Long id) {
        return authorRepository.findById(id);
    }

    /**
     * Save a new author to the database.
     * @param author the author to save
     * @return the saved author
     * @throws DataIntegrityViolationException if email already exists
     */
    public Author save(Author author) throws DataIntegrityViolationException {
        return authorRepository.save(author);
    }

    /**
     * Update an existing author's details.
     * @param id the ID of the author to update
     * @param updatedAuthor the updated author data
     * @return the updated author
     * @throws RuntimeException if author not found
     * @throws DataIntegrityViolationException if email already exists
     */
    public Author update(Long id, Author updatedAuthor) throws DataIntegrityViolationException {
        Optional<Author> existingOpt = authorRepository.findById(id);
        if (!existingOpt.isPresent()) {
            throw new RuntimeException("Author not found with id: " + id);
        }
        Author existing = existingOpt.get();
        existing.setName(updatedAuthor.getName());
        existing.setEmail(updatedAuthor.getEmail());
        existing.setBio(updatedAuthor.getBio());
        return authorRepository.save(existing);
    }
}
