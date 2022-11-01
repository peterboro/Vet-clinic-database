CREATE TABLE patients (
  id BIGSERIAL NOT NULL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  date_of_birth DATE NOT NULL,
);

CREATE TABLE medical_histories (
  id BIGSERIAL NOT NULL PRIMARY KEY,
  admitted_at TIMESTAMP,
  status VARCHAR(50) NOT NULL,
  patient_id INT REFERENCES patients(id),
);

CREATE TABLE invoices (
  id BIGSERIAL NOT NULL PRIMARY KEY,
  total_amount DECIMAL NOT NULL,
  generated_at TIMESTAMP,
  paid_at TIMESTAMP,
  medical_history_id INT REFERENCES medical_histories(id),
);
