-- Datenbankstruktur für Windpark-Verwaltung
-- Wird beim ersten Start des Postgres-Containers automatisch ausgeführt

DROP TABLE IF EXISTS betriebsdaten CASCADE;
DROP TABLE IF EXISTS windrad CASCADE;
DROP TABLE IF EXISTS windpark CASCADE;

CREATE TABLE windpark (
    idwindpark SERIAL PRIMARY KEY,
    standortwindpark VARCHAR(100) NOT NULL,
    betreibergesellschaft VARCHAR(100) NOT NULL,
    flaechewindpark NUMERIC(10,2) NOT NULL,
    erweiterungsfaehig BOOLEAN NOT NULL
);

CREATE TABLE windrad (
    idwindrad SERIAL PRIMARY KEY,
    windradtyp VARCHAR(100) NOT NULL,
    baujahr INT NOT NULL CHECK (baujahr >= 1980 AND baujahr <= 2100),
    nabenhoehe NUMERIC(6,2) NOT NULL,
    leistungmaximal NUMERIC(8,2) NOT NULL,
    leistungaktuell NUMERIC(8,2) NOT NULL,
    idwindpark INT NOT NULL,
    CONSTRAINT fk_windrad_windpark
        FOREIGN KEY (idwindpark)
        REFERENCES windpark(idwindpark)
        ON DELETE CASCADE
);

CREATE TABLE betriebsdaten (
    idlog SERIAL PRIMARY KEY,
    datum DATE NOT NULL,
    tageserzeugung NUMERIC(10,2) NOT NULL,
    idwindrad INT NOT NULL,
    CONSTRAINT fk_betriebsdaten_windrad
        FOREIGN KEY (idwindrad)
        REFERENCES windrad(idwindrad)
        ON DELETE CASCADE,
    CONSTRAINT uq_betriebsdaten UNIQUE (datum, idwindrad)
);

INSERT INTO windpark (standortwindpark, betreibergesellschaft, flaechewindpark, erweiterungsfaehig) VALUES
('Nordseeküste', 'GreenWind GmbH', 125.50, true),
('Eifel-West', 'EcoPower AG', 98.20, false),
('Hunsrück Süd', 'Windkraft Saar-Mosel', 143.70, true);

INSERT INTO windrad (windradtyp, baujahr, nabenhoehe, leistungmaximal, leistungaktuell, idwindpark) VALUES
('Enercon E-115', 2019, 149.00, 3.20, 2.80, 1),
('Vestas V112', 2018, 140.00, 3.00, 2.40, 1),
('Nordex N117', 2020, 141.00, 3.60, 3.10, 2),
('Siemens SWT-3.6', 2017, 120.00, 3.60, 2.90, 2),
('Enercon E-138', 2021, 160.00, 4.20, 3.90, 3),
('Vestas V126', 2022, 166.00, 3.45, 3.20, 3);

INSERT INTO betriebsdaten (datum, tageserzeugung, idwindrad) VALUES
('2025-01-10', 18.4, 1),
('2025-01-11', 20.1, 1),
('2025-01-12', 17.8, 1),
('2025-01-10', 16.9, 2),
('2025-01-11', 15.2, 2),
('2025-01-12', 19.0, 2),
('2025-01-10', 21.5, 3),
('2025-01-11', 22.3, 3),
('2025-01-12', 20.7, 3),
('2025-01-10', 19.1, 4),
('2025-01-11', 18.6, 4),
('2025-01-12', 17.4, 4),
('2025-01-10', 24.8, 5),
('2025-01-11', 25.6, 5),
('2025-01-12', 23.9, 5),
('2025-01-10', 20.3, 6),
('2025-01-11', 21.7, 6),
('2025-01-12', 22.1, 6);
