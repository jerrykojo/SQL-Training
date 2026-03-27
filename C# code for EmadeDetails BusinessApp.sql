--To create code on c#
USE EMADEDEV

CREATE TABLE EmadeDetails(user_id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
user_name VARCHAR(50) NOT NULL,
user_age INT NOT NULL);

--Check data
SELECT * FROM EmadeDetails

INSERT INTO EmadeDETAILS(user_name, user_age) VALUES('Emmanuel',10)