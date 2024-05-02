CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    type ENUM('Individual', 'Group', 'Administrator') NOT NULL,
    organization_name VARCHAR(255),
    organization_type VARCHAR(255),
    organization_contact_info VARCHAR(255),
    contact_address VARCHAR(255),
    contact_phone VARCHAR(20),
	is_active BOOLEAN DEFAULT true, -- New column for indicating user activity
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- New column for user creation timestamp
    -- Additional profile information columns
    -- (name, contact details, etc.)
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);

CREATE TABLE MissingPersons (
    missing_person_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    age INT,
    gender ENUM('Masculino', 'Feminino', 'Outro'),
    description TEXT,
    last_known_location_id INT,
    contact_info VARCHAR(255),
    photo_url VARCHAR(255), -- New column for storing photo URL
    reported_by INT,
    reported_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- New column for user creation timestamp
    status ENUM('Ativo', 'Resolvido') DEFAULT 'Ativo',
    FOREIGN KEY (last_known_location_id) REFERENCES Locations(location_id),
    FOREIGN KEY (reported_by) REFERENCES Users(user_id)
);

CREATE TABLE Countries (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(255) NOT NULL
);

CREATE TABLE Provinces (
    province_id INT AUTO_INCREMENT PRIMARY KEY,
    country_id INT,
    province_name VARCHAR(255) NOT NULL,
    FOREIGN KEY (country_id) REFERENCES Countries(country_id)
);

CREATE TABLE Districts (
    district_id INT AUTO_INCREMENT PRIMARY KEY,
    province_id INT,
    district_name VARCHAR(255) NOT NULL,
    FOREIGN KEY (province_id) REFERENCES Provinces(province_id)
);

CREATE TABLE Locations (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    country_id INT,
    province_id INT,
    district_id INT,
    FOREIGN KEY (country_id) REFERENCES Countries(country_id),
    FOREIGN KEY (province_id) REFERENCES Provinces(province_id),
    FOREIGN KEY (district_id) REFERENCES Districts(district_id)
);

CREATE TABLE Comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    missing_person_id INT,
    comment TEXT,
    posted_by INT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (missing_person_id) REFERENCES MissingPersons(missing_person_id),
    FOREIGN KEY (posted_by) REFERENCES Users(user_id)
);
-- Add a new column 'description' to the Location table
ALTER TABLE Location
ADD COLUMN description VARCHAR(255);

-- Add a foreign key constraint to reference the District table
ALTER TABLE Location
ADD CONSTRAINT fk_location_district
FOREIGN KEY (district_id)
REFERENCES District(district_id);
