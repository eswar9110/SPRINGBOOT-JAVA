package com.bookauthor.app.repository;

import com.bookauthor.app.model.Author;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for AuthorRepository.
 * Uses @DataJpaTest for an in-memory database slice test.
 */
@DataJpaTest
public class AuthorRepositoryTest {

    @Autowired
    private TestEntityManager entityManager;

    @Autowired
    private AuthorRepository authorRepository;

    @Test
    public void testSaveAuthor() {
        Author author = new Author("Test Author", "test@email.com", "A test bio");
        Author saved = authorRepository.save(author);

        assertNotNull(saved.getId());
        assertEquals("Test Author", saved.getName());
        assertEquals("test@email.com", saved.getEmail());
    }

    @Test
    public void testFindAllAuthors() {
        entityManager.persist(new Author("Author One", "one@email.com", "Bio one"));
        entityManager.persist(new Author("Author Two", "two@email.com", "Bio two"));
        entityManager.flush();

        List<Author> authors = authorRepository.findAll();
        assertTrue(authors.size() >= 2);
    }

    @Test
    public void testFindById() {
        Author author = new Author("Find Me", "findme@email.com", "Find bio");
        Author persisted = entityManager.persist(author);
        entityManager.flush();

        Optional<Author> found = authorRepository.findById(persisted.getId());
        assertTrue(found.isPresent());
        assertEquals("Find Me", found.get().getName());
    }

    @Test
    public void testFindByEmail() {
        Author author = new Author("Email Author", "unique@email.com", "Email bio");
        entityManager.persist(author);
        entityManager.flush();

        Author found = authorRepository.findByEmail("unique@email.com");
        assertNotNull(found);
        assertEquals("Email Author", found.getName());
    }

    @Test
    public void testUpdateAuthor() {
        Author author = new Author("Old Name", "update@email.com", "Old bio");
        Author persisted = entityManager.persist(author);
        entityManager.flush();

        persisted.setName("New Name");
        persisted.setBio("New bio");
        Author updated = authorRepository.save(persisted);

        assertEquals("New Name", updated.getName());
        assertEquals("New bio", updated.getBio());
    }

    @Test
    public void testFindByEmailNotFound() {
        Author found = authorRepository.findByEmail("nonexistent@email.com");
        assertNull(found);
    }
}
