create or alter procedure bronze.load_bronze as 
	begin

	declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime
	begin try
	set @batch_start_time = getdate()


	print '================================='
	print 'Loading Bronze Layer'
	print '================================='


		print '---------------------------------'
		print 'Loading CRM Tables'
		print '---------------------------------'

		
			truncate table bronze.crm_cust_info
			if object_id ('bronze.crm_cust_info', 'U') is not null
				drop table bronze.crm_cust_info

			create table bronze.crm_cust_info (
				cst_if int,
				cst_key nvarchar(50),
				cst_firstname nvarchar(50),
				cst_lastname nvarchar(50),
				cst_material_status nvarchar(50),
				cst_gndr nvarchar(50),
				cst_create_date date
			)

			truncate table bronze.crm_prd_info
			if object_id ('bronze.crm_prd_info', 'U') is not null
				drop table bronze.crm_prd_info

			create table bronze.crm_prd_info (
				prd_id int,
				prd_key nvarchar(50),
				prd_nm nvarchar(50),
				prd_cost int,
				prd_line nvarchar(50),
				prd_start_date date,
				prd_end_date date
			)

			truncate table bronze.crm_sales_details
			if object_id ('bronze.crm_sales_details', 'U') is not null
				drop table bronze.crm_sales_details

			create table bronze.crm_sales_details (
				sls_ord_num nvarchar(50),
				sls_prd_key nvarchar(50),
				sls_cust_id int,
				sls_order_dt int,
				sls_due_dt int,
				sls_sales int,
				sls_quantity int,
				sls_price nvarchar(50)
			)


		print '---------------------------------'
		print 'Loading ERP Tables'
		print '---------------------------------'

			truncate table bronze.erp_CUST_AZ12
			if object_id ('bronze.erp_CUST_AZ12', 'U') is not null
				drop table bronze.erp_CUST_AZ12

			create table bronze.erp_CUST_AZ12 (
				CID nvarchar(50),
				BDATE date,
				GEN nvarchar(50)
			)

			truncate table bronze.erp_LOC_A101
			if object_id ('bronze.erp_LOC_A101', 'U') is not null
				drop table bronze.erp_LOC_A101

			create table bronze.erp_LOC_A101 (
				CID nvarchar(50),
				CNTRY nvarchar(50)
			)

			truncate table bronze.erp_PX_CAT_G1V2
			if object_id ('bronze.erp_PX_CAT_G1V2', 'U') is not null
				drop table bronze.erp_PX_CAT_G1V2

			create table bronze.erp_PX_CAT_G1V2 (
				ID nvarchar(50),
				CAT nvarchar(50),
				SUBCAT nvarchar(50),
				MAINTAINANCE nvarchar(50)
			)




			-- For bronze.crm_cust_info
			set @start_time = getdate()
			print 'Truncating Table: bronze.crm_cust_info'
			truncate table bronze.crm_cust_info

			print 'Inserting Data into: bronze.crm_cust_info' 
			bulk insert bronze.crm_cust_info
			from 'C:\Users\Aaryan Magar\OneDrive\Desktop\Data Warehouse Project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
			with (
				firstrow = 2,
				fieldterminator = ',',
				tablock
			)
			set @end_time = getdate()
			print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'
			

			-- For bronze.crm_prd_info
			set @start_time = getdate()
			print 'Truncating Table: bronze.crm_prd_info'
			truncate table bronze.crm_prd_info

			print 'Inserting Data into: bronze.crm_prd_info' 
			bulk insert bronze.crm_prd_info
			from 'C:\Users\Aaryan Magar\OneDrive\Desktop\Data Warehouse Project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
			with (
				firstrow = 2,
				fieldterminator = ',',
				tablock
			)
			set @end_time = getdate()
			print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'

			

			-- For bronze.crm_sales_details
			set @start_time = getdate()
			print 'Truncating Table: bronze.crm_sales_details'
			truncate table bronze.crm_sales_details

			print 'Inserting Data into: bronze.crm_sales_details' 
			bulk insert bronze.crm_sales_details
			from 'C:\Users\Aaryan Magar\OneDrive\Desktop\Data Warehouse Project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
			with (
				firstrow = 2,
				fieldterminator = ',',
				tablock
			)
			set @end_time = getdate()
			print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'

			

			-- For bronze.erp_CUST_AZ12
			set @start_time = getdate()
			print 'Truncating Table: bronze.erp_CUST_AZ12'
			truncate table bronze.erp_CUST_AZ12

			print 'Inserting Data into: bronze.erp_CUST_AZ12' 
			bulk insert bronze.erp_CUST_AZ12
			from 'C:\Users\Aaryan Magar\OneDrive\Desktop\Data Warehouse Project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
			with (
				firstrow = 2,
				fieldterminator = ',',
				tablock
			)
			set @end_time = getdate()
			print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'

			

			-- For bronze.erp_erp_LOC_A101
			set @start_time = getdate()
			print 'Truncating Table: bronze.erp_LOC_A101'
			truncate table bronze.erp_LOC_A101

			print 'Inserting Data into: bronze.erp_LOC_A101' 
			bulk insert bronze.erp_LOC_A101
			from 'C:\Users\Aaryan Magar\OneDrive\Desktop\Data Warehouse Project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
			with (
				firstrow = 2,
				fieldterminator = ',',
				tablock
			)
			set @end_time = getdate()
			print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'

			

			-- For bronze.erp_PX_CAT_G1V2
			set @start_time = getdate()
			print 'Truncating Table: bronze.erp_PX_CAT_G1V2'
			truncate table bronze.erp_PX_CAT_G1V2

			print 'Inserting Data into: bronze.erp_PX_CAT_G1V2' 
			bulk insert bronze.erp_PX_CAT_G1V2
			from 'C:\Users\Aaryan Magar\OneDrive\Desktop\Data Warehouse Project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
			with (
				firstrow = 2,
				fieldterminator = ',',
				tablock
			)
			set @end_time = getdate()
			print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'
			print '>> -------------'

			set @batch_end_time = getdate()
			print '==========================================='
			print 'Loading Bronze Layer is Completed'
			print ' - Total Load Duration: ' + cast(datediff(second, @batch_start_time, @batch_end_time) as nvarchar) + ' seconds'

		end try
		begin catch
			print '==========================================='
			print 'ERROR OCCURED DURING LOADING BRONZE LAYER'
			print 'Error Message' + cast (error_message() as nvarchar)
			print 'Error Message' + cast (error_number() as nvarchar)
			print '==========================================='
		end catch


end
