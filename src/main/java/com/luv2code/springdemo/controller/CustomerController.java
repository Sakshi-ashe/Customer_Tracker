package com.luv2code.springdemo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.luv2code.springdemo.DAO.CustomerDAO;
import com.luv2code.springdemo.entity.Customer;
import com.luv2code.springdemo.service.CustomerService;
import com.luv2code.springdemo.util.SortUtils;

@Controller
@RequestMapping("/customer")
public class CustomerController {
	
	//inject service to controller
	@Autowired
	private CustomerService customerService;

//	@GetMapping("/list")	//accessing url in browser sends GET request
//	public String listCustomers(Model theModel) {
//		
//		//get customers from the service 
//		List<Customer> theCustomers = customerService.getCustomers();
//		
//		// add customers to model
//		theModel.addAttribute("customers",theCustomers);
//		
//		
//		return "list-customers";
//	}
	
	@GetMapping("/showFormForAdd")
	public String showFormForAdd(Model theModel) {
		
		//create model attribute to bind form data
		Customer theCustomer = new Customer();
		
		theModel.addAttribute("customer", theCustomer);
		return "customer-form";
	}
	
	@PostMapping("/saveCustomer")
	public String saveCustomer(@ModelAttribute("customer") Customer theCustomer) {
		
		// save the customer using service
		customerService.saveCustomer(theCustomer);
		return "redirect:/customer/list";
	}
	
	@GetMapping("/showFormForUpdate")
	public String showFormForUpdate(@RequestParam("customerId") int theId,
									Model theModel) {
		//get the customer from the database
		Customer theCustomer = customerService.getCustomer(theId);
		
		//set the customer as a model attribute to pre-populate the form
		theModel.addAttribute("customer", theCustomer);
		
		//send over to our form
		return "customer-form";
		
	}
	
	@GetMapping("/delete")
	public String deleteCustomer(@RequestParam("customerId") int theId,
			Model theModel) {
		
		//get the customer from the database
		Customer theCustomer = customerService.getCustomer(theId);
		
		//delete
		customerService.deleteCustomer(theId);
		
		return "redirect:/customer/list";
	}

	
	 @GetMapping("/search")
	    public String searchCustomers(@RequestParam("theSearchName") String theSearchName,
	                                    Model theModel) {
	        // search customers from the service
	        List<Customer> theCustomers = customerService.searchCustomers(theSearchName);
	                
	        // add the customers to the model
	        theModel.addAttribute("customers", theCustomers);
	        return "list-customers";        
	    }
	 
 	@GetMapping("/list")
 	public String listCustomers(Model theModel, @RequestParam(required=false) String sort) {
 		
 		// get customers from the service
 		List<Customer> theCustomers = null;
 		
 		// check for sort field
 		if (sort != null) {
 			int theSortField = Integer.parseInt(sort);
 			theCustomers = customerService.getCustomers(theSortField);			
 		}
 		else {
 			// no sort field provided ... default to sorting by last name
 			theCustomers = customerService.getCustomers(SortUtils.LAST_NAME);
 		}
 		
 		// add the customers to the model
 		theModel.addAttribute("customers", theCustomers);
 		
 		return "list-customers";
 	}
}
