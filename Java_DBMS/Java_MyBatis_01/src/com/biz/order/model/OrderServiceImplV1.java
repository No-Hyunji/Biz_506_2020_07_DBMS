package com.biz.order.model;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.biz.order.config.DBConnection;
import com.biz.order.mapper.OrderDao;

public class OrderServiceImplV1 implements OrderService{
	
	private SqlSession sqlSession;
	private OrderDao orderDao;
	
	public OrderServiceImplV1() {
		/*
		 * openSession() 매개변수
		 * true : insert, update, delete수행한 후 자동으로  Auto Commit으 ㄹ수행
		 * CUD 수행한 후에 DB에 결과를 확실히 저장하라
		 * 
		 * false, 없으면 : Auto Commit 수행하지 말라
		 */
		sqlSession = DBConnection
				.getSqlSessionFactory()
				.openSession(true);
		orderDao = sqlSession.getMapper(OrderDao.class);
	}
	@Override
	public List<OrderVO> selectAll() {
		
		List<OrderVO> orderList = orderDao.selectAll();
		
		return orderList;
	}

	@Override
	public OrderVO findBySeq(long seq) {
		OrderVO orderVO = orderDao.findBySeq(seq);
		
		
		return orderVO;
	}

	@Override
	public int insert(OrderVO orderVO) {
		
		Date date = new Date(System.currentTimeMillis());
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		
		// 날짜 칼럼 세팅
		orderVO.setO_date(df.format(date));
		
		int ret = orderDao.insert(orderVO);
		return ret;
	}

	@Override
	public int update(OrderVO orderVO) {
		int ret = orderDao.update(orderVO);
		
		return ret;
	}

	@Override
	public int delete(long seq) {
		int ret = orderDao.delete(seq);
		return ret;
	}
	

}
