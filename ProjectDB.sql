CREATE TABLE "portfolio" (
  "portfolio_id" serial,
  "portfolio_name" varchar(100),
  PRIMARY KEY ("portfolio_id")
);

CREATE TABLE "ticker" (
  "ticker_id" serial,
  "ticker_name" varchar(6),
  "company_name" varchar(100),
  PRIMARY KEY ("ticker_id")
);

CREATE TABLE "price" (
  "ticker_id" int,
  "date" date,
  "close_price" float,
	"ticker_name" varchar(6),
--  PRIMARY KEY ("ticker_id", "date"),
	foreign key
	("ticker_id") references "ticker" ("ticker_id")
);

CREATE TABLE "portfolio_tickers" (
  "ticker_id" int,
  "portfolio_id" int,
  "weight" float,
	foreign key 
	("ticker_id") references "ticker" ("ticker_id"),
	foreign key 
	("portfolio_id") references "portfolio" ("portfolio_id")
);


insert into portfolio ("portfolio_name")
values
('food'),
('communication'),
('financial'),
('hedge'),
('pharma');

create table pt_temp ("ticker" varchar(6), "company_name" varchar(100), "portfolio_name" varchar(100));

insert into portfolio_tickers
select ticker_id, portfolio_id, 0.25 from portfolio p
inner join pt_temp pt
on pt.portfolio_name = p.portfolio_name
inner join ticker t
on pt.ticker = t.ticker_name;

select * from portfolio;

select distinct pt.portfolio_name 
from pt_temp pt;

update pt_temp set portfolio_name = 'financial'
where portfolio_name = 'financial ';

select * from potfolio_tickers;
alter table price add CovidInEffect boolean default FALSE;

insert into portfolio (portfolio_name)
values ('S&P500');
insert into ticker (ticker_name, company_name)
values ('SP500', 'Standard & Poors 500');
insert into portfolio_tickers (ticker_id,portfolio_id, weight)
values (
    (select ticker_id from ticker where ticker_name = 'SP500'),
    (select portfolio_id from portfolio where portfolio_name = 'S&P500'),
    1
);


select * from ticker;

select * from price;
