package com.biz.order.service;

 

import java.util.Scanner;

import com.biz.order.model.OrderService;
import com.biz.order.model.OrderServiceImplV1;
import com.biz.order.model.OrderVO;

 

public class OrderInput {

 

	Scanner scan;

	private OrderService oService;

 

	public OrderInput() {

		scan = new Scanner(System.in);

		oService = new OrderServiceImplV1();

	}

 

	public boolean orderInsert() {

		OrderVO orderVO = new OrderVO();

 

		System.out.print("주문번호(QUIT:중단)>> ");

		String strNum = scan.nextLine();

 

		if (strNum.equals("QUIT")) {

			return false;

		}

		orderVO.setO_num(strNum);
		
		if(orderVO.getO_num().isEmpty()) {
			System.out.println(" 주문번호는 반드시 입력해야 합니다. ");
			return true;
		}

 
		while(true) {
		System.out.print("고객번호(QUIT:중단)>> ");

		String strCNum = scan.nextLine();

 

		if (strCNum.equals("QUIT")) {

			return false;

		}

		orderVO.setO_cnum(strCNum);
		if(orderVO.getO_cnum().isEmpty()) {
			System.out.println("고객정보는 반드시 입력해야합니다.");
			continue;
		}
		break;

		}
		
		while(true) {
		System.out.print("상품코드(QUIT:중단)>> ");

		String strPCode = scan.nextLine();

 

		if (strPCode.equals("QUIT")) {

			return false;

		}

		orderVO.setO_pcode(strPCode);

		if(order)

		while (true) {

			System.out.print("상품가격(QUIT:중단)>> ");

			String strPrice = scan.nextLine();

 

			if (strPrice.equals("QUIT")) {

				return false;

			}

 

			int intPrice = 0;

			try {

				intPrice = Integer.valueOf(strPrice);

			} catch (Exception e) {

				System.out.println("상품가격은 숫자로만 입력하세요");

			}

			orderVO.setO_price(intPrice);

			break;

		}

		

		while (true) {

			System.out.print("주문수량(QUIT:중단)>> ");

			String strQty = scan.nextLine();

 

			if (strQty.equals("QUIT")) {

				return false;

			}

 

			int intQty = 0;

			try {

				intQty = Integer.valueOf(strQty);

			} catch (Exception e) {

				System.out.println("주문수량은 숫자로만 입력하세요");

			}

			orderVO.setO_price(intQty);

			break;

		}

		

		int ret = oService.insert(orderVO);

		

		if(ret > 0) {

			System.out.println("주문서를 추가하였습니다.");

		}else {

			System.out.println("주문서를 추가하지 못했습니다.");

			System.out.println("다시 입력해주세요");

		}

 

		return true;

	}

}

