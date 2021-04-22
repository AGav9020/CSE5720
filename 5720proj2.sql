/*
After talking with Jin, she said it was an issue with Pycharm itself on how it's allowing the queries.
She said to turn this in to receive credit. I'm also turning in the python file itself as documented proof, as well as my "scratch" SQL file.
*/


use cse5720proj2;
/*
# In table “publisher”, there is already some data: A list of publisher IDs, names,
    # emails and phone numbers. Your program should print out all the data in this table.
*/
SELECT pubID, pname, email, phone FROM publishers;

/*
2. Create a table called customers.
*/
drop table customers;
create table `customers`(
             `custID` INT(5) NOT NULL AUTO_INCREMENT,
             `custName` varchar(30) null,
             `zipcode` varchar(30) null,
             `city` varchar(30) null,
             `state` varchar(30) null,
             primary key(`custID`));

/*
3. Insert data into customers
*/
insert into customers(custName)
values 	('STEPHEN WALTHER'),
		('KEVIN LONEY'),
		('MARTIN GARRIX'),
        ('CALVIN HARRIS'),
        ('PAMELA REIF');


/*
4. Form a query to print the names of those who appear 
in both “author” and “customer.”
*/
select au.aname
from authors au
inner join customers cu on cu.custname=au.aname;


/*
5. Form a query to find the author who worked for a book with 
price more than $475
*/
select 
	 a.aname
    ,b.title
    ,b.price
from authors a
inner join titleauthors t on t.auID = a.auID
inner join titles b on b.titleID = t.titleID
where b.price>475;

/*
6. Form a query to find publishers that worked with ‘Kevin Loney’.
*/
select p.pname
from publishers p
inner join titles t on t.pubID= p.pubID
inner join titleauthors ta on ta.titleID = t.titleID
inner join authors a on a.auID = ta.auID
where a.aname = 'Kevin Loney';

/*
7. Form a query to delete authors who have not written any title.
*/
delete
from authors a
where auID NOT IN (select auID from titleauthors);

/*
8. insert a row into titleauthors for title ‘java.comp.ref’ 
and author ‘Davaid Hunter’
*/
set @auID = (select a.auID from authors a where a.aname = 'Davaid Hunter');
set @titleID = (select t.titleID from titles t where t.title = 'JAVA COMP. REF');
insert into titleauthors (titleID, auID)
values (@titleID, @auID);

/*
9. Form a query to find the subject for which we have more than 2 books 
written by more than one author.
*/
select subID from titles where titleID in
(select titleID from titleauthors group by titleID having count(*)>1)
group by subID having count(*)>2;

/*
10. Form a query to increase the price of all the books by 20%
*/
update titles
set price=price * 1.2;