Describe 'Database setup and query execution'

	Include ./db_config.sh

	BeforeAll 'setup_database'
	AfterAll 'cleanup_database'

	Describe 'select_all'
	  
		Skip "Initial Set Up"
		It 'executes select_all_from_categorie without errors'
		  When call select_all_from_categories
		  The status should be success
		  The output should include "8 rows"
		End

		It 'executes select_all_from_customers without errors'
		  When call select_all_from_customers
		  The status should be success
		  The output should include "91 rows"
		End

		It 'executes select_all_from_products without errors'
		  When call select_all_from_products
		  The status should be success
		  The output should include "77 rows"
		End

		It 'executes select_all_from_orders without errors'
		  When call select_all_from_orders
		  The status should be success
		  The output should include "830 rows"
		End

		It 'executes select_all_from_order_details without errors'
		  When call select_all_from_order_details
		  The status should be success
		  The output should include "2155 rows"
		End

		It 'executes select_all_from_testproducts without errors'
		  When call select_all_from_testproducts
		  The status should be success
		  The output should include "10 rows"
		End

	End


  End
