package model;

public class Order { 
	String userName;
	int quantity, total;
	
	public Order() {}
	
	public Order(int quantity, int total, 
			String userName){
		
		this.quantity = quantity;
		this.total = total;
		this.userName = userName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}



	

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}


	
	
}
