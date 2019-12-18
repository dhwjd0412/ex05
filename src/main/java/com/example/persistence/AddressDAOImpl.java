package com.example.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.domain.AddressVO;

@Repository
public class AddressDAOImpl implements AddressDAO{
	@Inject
	SqlSession session;
	private static final String namespace="AddressMapper";
	
	@Override
	public List<AddressVO> list(int start) {
		return session.selectList(namespace + ".list", start);
	}

	@Override
	public int total() {
		// TODO Auto-generated method stub
		return session.selectOne(namespace +".total");
	}

	@Override
	public void insert(AddressVO vo) throws Exception{
		// TODO Auto-generated method stub
		session.insert(namespace + ".insert", vo); 
	}

	@Override
	public void delete(int id) throws Exception {
		// TODO Auto-generated method stub
		session.delete(namespace + ".delete", id);
	}



	@Override
	public AddressVO read(int id) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".read", id);
	}

	@Override
	public void update(AddressVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace +".update",vo); 
	}

	
	
}
