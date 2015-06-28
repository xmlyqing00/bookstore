drop table orders;
create table orders ( title varchar(100), quantity integer, login varchar(8), director varchar(10) );

insert into orders values ('2001: A Space Odyssey',2,'user1','Kubrick');
insert into orders values ('Full Metal Jacket',1,'user1','Kubrick');
insert into orders values ('The shining',2,'user1','Kubrick');
insert into orders values ('Barry Lyndon',2,'user1','Kubrick');
insert into orders values ('Eyes Wide Shut',2,'user1','Kubrick');
 
insert into orders values ('Dr. Strangelove or: How I Learned to Stop Worrying and Love the Bomb',2,'user2','Kubrick');
insert into orders values ('2001: A Space Odyssey',2,'user2','Kubrick');
insert into orders values ('Full Metal Jacket',1,'user2','Kubrick');
insert into orders values ('A Clockwork Orange',1,'user2','Kubrick');
