CREATE TABLE patients (
  id BIGSERIAL NOT NULL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  date_of_birth DATE NOT NULL,
);

CREATE TABLE medical_histories (
  id SERIAL NOT NULL PRIMARY KEY,
  admitted_at TIMESTAMP,
  status VARCHAR(150) NOT NULL,
  patient_id INT REFERENCES patients(id),
);

CREATE TABLE invoices (
  id SERIAL NOT NULL PRIMARY KEY,
  total_amount DECIMAL NOT NULL,
  generated_at TIMESTAMP,
  paid_at TIMESTAMP,
  medical_history_id INT REFERENCES medical_histories(id),
);

CREATE TABLE treatments (
  id SERIAL NOT NULL PRIMARY KEY,
  type VARCHAR(150) NOT NULL,
  name VARCHAR(150) NOT NULL,
  invoice_id INT REFERENCES invoices(id),
);

CREATE TABLE invoice_items (
  id SERIAL NOT NULL PRIMARY KEY,
  unit_price DECIMAL NOT NULL,
  quantity INT NOT NULL,
  total_amount DECIMAL NOT NULL,
  invoice_id INT REFERENCES invoices(id),
  treatment_id INT REFERENCES treatments(id),
);

CREATE TABLE medical_histories_treatments (
  id SERIAL NOT NULL PRIMARY KEY,
  medical_history_id INT REFERENCES medical_histories(id),
  treatment_id INT REFERENCES treatments(id),
);

CREATE INDEX patients_id ON patients (id);
CREATE INDEX medical_histories_id ON medical_histories (id);
CREATE INDEX invoices_id ON invoices (id);
CREATE INDEX treatments_id ON treatments (id);
CREATE INDEX invoice_items_id ON invoice_items (id);
CREATE INDEX medical_histories_treatments_id ON medical_histories_treatments (id);
CREATE INDEX medical_histories_treatments_medical_history_id ON medical_histories_treatments (medical_history_id);
CREATE INDEX medical_histories_treatments_treatment_id ON medical_histories_treatments (treatment_id);