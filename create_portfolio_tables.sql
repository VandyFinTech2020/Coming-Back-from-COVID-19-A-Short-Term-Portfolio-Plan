CREATE TABLE "portfolio" (
  "portfolio_id" SERIAL,
  "portfolio_name" VARCHAR(100),
  PRIMARY KEY ("portfolio_id")
);

CREATE TABLE "ticker" (
  "ticker_id" SERIAL,
  "ticker_name" VARCHAR(6),
  "company_name" VARCHAR(100),
  PRIMARY KEY ("ticker_id")
);

CREATE TABLE "price" (
  "ticker_id" int,
  "DATE" DATE,
  "close_price" FLOAT,
	"ticker_name" VARCHAR(6),
--  PRIMARY KEY ("ticker_id", "DATE"),
	FOREIGN KEY
	("ticker_id") REFERENCES "ticker" ("ticker_id")
);

CREATE TABLE "portfolio_tickers" (
  "ticker_id" int,
  "portfolio_id" int,
  "weight" FLOAT,
	FOREIGN KEY 
	("ticker_id") REFERENCES "ticker" ("ticker_id"),
	FOREIGN KEY 
	("portfolio_id") REFERENCES "portfolio" ("portfolio_id")
);


INSERT INTO portfolio ("portfolio_name")
VALUES
('food'),
('communicatiON'),
('financial'),
('hedge'),
('pharma');

CREATE TABLE pt_temp ("ticker" VARCHAR(6), "company_name" VARCHAR(100), "portfolio_name" VARCHAR(100));

INSERT INTO portfolio_tickers
SELECT ticker_id, portfolio_id, 0.25 FROM portfolio p
INNER join pt_temp pt
ON pt.portfolio_name = p.portfolio_name
INNER join ticker t
ON pt.ticker = t.ticker_name;

SELECT * FROM portfolio;

SELECT distinct pt.portfolio_name 
FROM pt_temp pt;

UPDATE pt_temp SET portfolio_name = 'financial'
WHERE portfolio_name = 'financial ';

SELECT * FROM potfolio_tickers;
