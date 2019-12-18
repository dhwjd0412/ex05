package com.example.web;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.AddressVO;
import com.example.persistence.AddressDAO;

@Controller
public class AddressController {
	@Inject
	AddressDAO dao;
	
	
	@RequestMapping("list.json")
	public @ResponseBody HashMap<String, Object> jsonList(Integer start){
		if(start == null) start=0;
		HashMap<String, Object> map=new HashMap<String, Object>();
		map.put("total", dao.total());
		map.put("list", dao.list(start));
		return map;
	}
	
	@RequestMapping("list")
	public String list(){
		return "list";
	}
	
	@RequestMapping(value="insert" , method=RequestMethod.POST)
	public @ResponseBody void insert(AddressVO vo){
			
		try{
			dao.insert(vo);
		
		}catch(Exception e){
			System.out.println(e.toString());
		}
		
	}
	@RequestMapping(value="update" , method=RequestMethod.POST)
	public @ResponseBody void update(AddressVO vo){
			
		try{
			dao.update(vo);
		
		}catch(Exception e){
			System.out.println(e.toString());
		}
		
	}
	@RequestMapping(value="delete", method=RequestMethod.POST)
	public  @ResponseBody void delete(int id){
		
		try{
			dao.delete(id);
			
		}catch(Exception e){
			System.out.println(e.toString());
		}
	
	
	}
	



	@RequestMapping("read.json")
	public @ResponseBody AddressVO jsonread (int id){
		AddressVO vo=null;
		try{
			vo=dao.read(id);
		}catch(Exception e){
			System.out.println(e.toString());
		}
		return vo;
	}
	

	
}
