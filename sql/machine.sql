create table machine(
  host_id varchar(100) primary key,
  name varchar(100),
  cluster_name varchar(100),
  ip varchar(50),
  image varchar(100),
  flavor varchar(10)
)
