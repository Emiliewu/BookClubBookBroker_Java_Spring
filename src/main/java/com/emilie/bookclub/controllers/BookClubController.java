package com.emilie.bookclub.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.emilie.bookclub.models.Book;
import com.emilie.bookclub.models.User;
import com.emilie.bookclub.services.BookService;
import com.emilie.bookclub.services.UserService;

@Controller
public class BookClubController {
	
	@Autowired
	UserService userServ;
	
	@Autowired
	BookService bookServ;
	
	//****dashboard for all books******
	@GetMapping("/books")
	public String dashboard(Model model, HttpSession session) {
		Long userId = (Long)session.getAttribute("user_id");
		if(userId == null) {
			return "redirect:/";
		} else {			
			User user = userServ.findUserById(userId);
			List<Book> allbooks = bookServ.findAllBooks();

			model.addAttribute("user", user);
			model.addAttribute("allbooks", allbooks);

		}		
		return "dashboard.jsp";
	}
	//****create a new book******
	@GetMapping("/books/new")
	public String newBook(@ModelAttribute("newbook") Book newbook, HttpSession session) {
		Long userId = (Long)session.getAttribute("user_id");
		if(userId == null) {
			return "redirect:/";
		} else {	
			return "newbook.jsp";
		}
		
	}
	
	@PostMapping("/books/create")
	public String createBook(@Valid @ModelAttribute("newbook") Book newbook, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			return "newbook.jsp";
		} else {
			Long userId = (Long)session.getAttribute("user_id");
			newbook.setOwner(userServ.findUserById(userId));
			bookServ.createNewBook(newbook);
			return "redirect:/books";
		}
	}
	
	//****edit a book******
	@GetMapping("/books/{id}/edit")
	public String editBook(@PathVariable("id") Long bookId, HttpSession session, Model model) {
		Long userId = (Long)session.getAttribute("user_id");
		Book editbook = bookServ.findBookById(bookId);
		if(userId == null) {
			return "redirect:/";
		} else {
			User user = userServ.findUserById(userId);
			if(editbook.getOwner().getId()==user.getId()) {				
				model.addAttribute("editbook", editbook);
				Long bid = editbook.getBorrower().getId();
				model.addAttribute("bid", bid);
				return "editbook.jsp";		
			} else {
				return "redirect:/books";
			}
		}		
	}
	@PutMapping("/books/{id}/update")
	public String updateBook(@Valid @ModelAttribute("editbook") Book editbook, BindingResult result, HttpSession session, @RequestParam("borrower") String bid) {
		Long userId = (Long)session.getAttribute("user_id");
		if(result.hasErrors()) {
			return "editbook.jsp";
		} else {
			editbook.setOwner(userServ.findUserById(userId));
			Long borrowerid = Long.parseLong(bid);
			editbook.setBorrower(userServ.findUserById(borrowerid));
			bookServ.updateBook(editbook);
			return "redirect:/books";
		}
	}
	
	//****show a book detail******
	@GetMapping("/books/{id}")
	public String bookDetail(@PathVariable("id") Long id, HttpSession session, Model model) {
		Long userId = (Long)session.getAttribute("user_id");
		if(userId == null) {
			return "redirect:/";
		} else {	
		Book book = bookServ.findBookById(id);
		User user = userServ.findUserById(userId);
		model.addAttribute("user", user);
		model.addAttribute("book", book);
		return "bookdetail.jsp";
		}
	}
	
	//****delete a book******
	@GetMapping("/books/{id}/delete")
	public String deleteBook(@PathVariable("id") Long id, HttpSession session) {
		Long userId = (Long)session.getAttribute("user_id");
		if(userId == null) {
			return "redirect:/";
		} else {
			User user = userServ.findUserById(userId);
			Book book = bookServ.findBookById(id);
			if(book.getOwner().getId()==user.getId()) {
				bookServ.deleteBook(id);
			} 
			return "redirect:/books";			
		}
	}
	
	//****bookmarket******
	@GetMapping("/bookmarket")
	public String bookMarket(Model model, HttpSession session) {
		Long userId = (Long)session.getAttribute("user_id");
		if(userId == null) {
			return "redirect:/";
		} else {
			User user = userServ.findUserById(userId);
			List<Book> allbooks = bookServ.findAllBooks();

			model.addAttribute("user", user);
			model.addAttribute("allbooks", allbooks);
			
			return "bookmarket.jsp";
		}
	}
	
	//****borrow a book******
	@GetMapping("/bookmarket/{id}/borrow")
	public String borrowBook(@PathVariable("id") Long id, HttpSession session) {
		Long userId = (Long)session.getAttribute("user_id");
		if(userId == null) {
			return "redirect:/";
		} else {
			User user = userServ.findUserById(userId);
			Book book = bookServ.findBookById(id);
			if(book.getOwner().getId()!=user.getId() && book.getBorrower()==null) {
				bookServ.borrowBook(userId, id);
			}
			return "redirect:/bookmarket";
		}
	}
	
	//****return a book******
	@GetMapping("/bookmarket/{id}/return")
	public String returnBook(@PathVariable("id") Long id, HttpSession session) {
		Long userId = (Long)session.getAttribute("user_id");
		if(userId == null) {
			return "redirect:/";
		} else {
			User user = userServ.findUserById(userId);
			Book book = bookServ.findBookById(id);
			if(book.getBorrower().getId()==user.getId()) {
				bookServ.returnBook(userId, id);
			}
			return "redirect:/bookmarket";
		}
	}
}
