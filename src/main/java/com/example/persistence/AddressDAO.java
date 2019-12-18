package com.example.persistence;

import java.util.List;

import com.example.domain.AddressVO;

public interface AddressDAO {
	public List<AddressVO> list(int start); 
	public int total();
	public void insert (AddressVO vo) throws Exception ;
	public void delete(int id) throws Exception;
	public void update(AddressVO vo) throws Exception;
	public AddressVO read(int id) throws Exception;
}
