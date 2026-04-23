-- =========================================================
-- KOMPLETTER NEUAUFBAU DER DATENBANK
-- Windpark / Windrad / Betriebsdaten
-- Geeignet fuer PostgreSQL
-- =========================================================

-- Alte Tabellen entfernen
DROP TABLE IF EXISTS betriebsdaten CASCADE;
DROP TABLE IF EXISTS windrad CASCADE;
DROP TABLE IF EXISTS windpark CASCADE;

-- =========================================================
-- 1) TABELLEN ANLEGEN
-- =========================================================

CREATE TABLE windpark (
    idwindpark INT PRIMARY KEY,
    standortwindpark VARCHAR(100) NOT NULL,
    betreibergesellschaft VARCHAR(100) NOT NULL,
    flaechewindpark NUMERIC(10,2) NOT NULL,
    erweiterungsfaehig BOOLEAN NOT NULL
);

CREATE TABLE windrad (
    idwindrad INT PRIMARY KEY,
    windradtyp VARCHAR(100) NOT NULL,
    baujahr INT NOT NULL CHECK (baujahr BETWEEN 1980 AND 2100),
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
    idlog BIGSERIAL PRIMARY KEY,
    datum DATE NOT NULL,
    tageserzeugung NUMERIC(10,2) NOT NULL,
    idwindrad INT NOT NULL,
    CONSTRAINT fk_betriebsdaten_windrad
        FOREIGN KEY (idwindrad)
        REFERENCES windrad(idwindrad)
        ON DELETE CASCADE,
    CONSTRAINT uq_betriebsdaten UNIQUE (datum, idwindrad)
);

-- =========================================================
-- 2) STAMMDATEN EINFUEGEN
-- =========================================================

INSERT INTO windpark (idwindpark, standortwindpark, betreibergesellschaft, flaechewindpark, erweiterungsfaehig)
VALUES
(101, 'Nordseekueste', 'GreenWind GmbH', 125.50, true),
(102, 'Kahler Asten', 'Sauerland Wind AG', 98.20, true),
(103, 'Eifel-West', 'EcoPower AG', 143.70, false),
(104, 'Hunsrueck Sued', 'Windkraft Saar-Mosel', 167.40, true),
(105, 'Harz Nord', 'SkyEnergy GmbH', 132.90, false),
(106, 'Ostfriesland Ost', 'BlueSky Energy GmbH', 151.80, true),
(107, 'Schwabenhoehe', 'TerraWind AG', 111.40, false),
(108, 'Thueringer Wald', 'NovaWatt GmbH', 174.30, true);

INSERT INTO windrad (idwindrad, windradtyp, baujahr, nabenhoehe, leistungmaximal, leistungaktuell, idwindpark)
VALUES
-- Windpark 101
(1001, 'Enercon E-115', 2018, 149.00, 3.20, 2.80, 101),
(1002, 'Vestas V112', 2019, 140.00, 3.00, 2.50, 101),
(1003, 'Nordex N117', 2020, 141.00, 3.60, 3.00, 101),
(1004, 'Siemens SWT-3.6', 2017, 120.00, 3.60, 2.70, 101),
(1005, 'Enercon E-138', 2021, 160.00, 4.20, 3.80, 101),

-- Windpark 102
(1006, 'Enercon E-115', 2018, 149.00, 3.20, 2.90, 102),
(1007, 'Vestas V112', 2019, 140.00, 3.00, 2.60, 102),
(1008, 'Nordex N117', 2020, 141.00, 3.60, 3.20, 102),
(1009, 'Siemens SWT-3.6', 2017, 120.00, 3.60, 2.95, 102),
(1010, 'Enercon E-138', 2021, 160.00, 4.20, 3.95, 102),

-- Windpark 103
(1011, 'Enercon E-115', 2018, 149.00, 3.20, 2.85, 103),
(1012, 'Vestas V126', 2021, 166.00, 3.45, 3.10, 103),
(1013, 'Nordex N131', 2022, 164.00, 3.90, 3.40, 103),
(1014, 'GE Cypress', 2020, 151.00, 4.00, 3.50, 103),
(1015, 'Siemens SG 4.5', 2021, 155.00, 4.50, 4.00, 103),

-- Windpark 104
(1016, 'Enercon E-82', 2016, 108.00, 2.30, 1.90, 104),
(1017, 'Vestas V90', 2015, 105.00, 2.00, 1.70, 104),
(1018, 'Nordex N100', 2017, 120.00, 2.50, 2.10, 104),
(1019, 'Siemens SWT-2.3', 2016, 115.00, 2.30, 2.00, 104),
(1020, 'Enercon E-92', 2018, 138.00, 2.35, 2.05, 104),

-- Windpark 105
(1021, 'Vestas V150', 2022, 165.00, 5.60, 5.00, 105),
(1022, 'Nordex N149', 2022, 164.00, 4.50, 4.10, 105),
(1023, 'GE 5.3-158', 2023, 161.00, 5.30, 4.80, 105),
(1024, 'Siemens SG 5.0', 2023, 157.00, 5.00, 4.60, 105),
(1025, 'Enercon E-160', 2023, 166.00, 5.50, 5.10, 105),

-- Windpark 106
(1026, 'Enercon E-126', 2020, 135.00, 4.00, 3.60, 106),
(1027, 'Vestas V136', 2021, 149.00, 4.20, 3.90, 106),
(1028, 'Nordex N133', 2020, 134.00, 4.80, 4.20, 106),
(1029, 'GE 4.8-158', 2022, 150.00, 4.80, 4.30, 106),
(1030, 'Siemens SG 4.2', 2021, 145.00, 4.20, 3.85, 106),

-- Windpark 107
(1031, 'Enercon E-70', 2014, 98.00, 2.30, 1.80, 107),
(1032, 'Vestas V80', 2013, 100.00, 2.00, 1.60, 107),
(1033, 'Nordex N90', 2015, 110.00, 2.40, 1.95, 107),
(1034, 'Siemens SWT-2.3', 2014, 115.00, 2.30, 1.85, 107),
(1035, 'Enercon E-82', 2016, 108.00, 2.30, 1.90, 107),

-- Windpark 108
(1036, 'Vestas V150', 2022, 165.00, 5.60, 5.05, 108),
(1037, 'Nordex N149', 2022, 164.00, 4.50, 4.15, 108),
(1038, 'GE 5.5-158', 2023, 161.00, 5.50, 4.95, 108),
(1039, 'Siemens SG 5.0', 2023, 157.00, 5.00, 4.70, 108),
(1040, 'Enercon E-160', 2023, 166.00, 5.50, 5.20, 108);

-- =========================================================
-- 3) VIELE BETRIEBSDATEN ERZEUGEN
-- Zeitraum: 2022-01-01 bis 2023-12-31
-- 40 Windraeder * 730 Tage = 29.200 Datensaetze
-- =========================================================

INSERT INTO betriebsdaten (datum, tageserzeugung, idwindrad)
SELECT
    d::date AS datum,
    ROUND(
        GREATEST(
            0.50,
            (
                w.leistungaktuell *
                (
                    5.2
                    + ((EXTRACT(DOY FROM d)::int % 17) * 0.22)
                    + ((EXTRACT(MONTH FROM d)::int % 5) * 0.18)
                )
                + ((w.idwindrad % 9) * 0.47)
            )
        )::numeric,
        2
    ) AS tageserzeugung,
    w.idwindrad
FROM generate_series('2022-01-01'::date, '2023-12-31'::date, interval '1 day') AS d
CROSS JOIN windrad w;

-- =========================================================
-- 4) TESTFALL EXPLIZIT SETZEN
-- Gesucht:
-- IDs der drei Windraeder im Windpark "Kahler Asten" (IDWindpark 102)
-- mit der hoechsten Tagesleistung am 03.05.2022
--
-- Gewolltes Ergebnis:
-- 1009, 1007, 1008
-- =========================================================

UPDATE betriebsdaten
SET tageserzeugung = 18.40
WHERE datum = '2022-05-03' AND idwindrad = 1006;

UPDATE betriebsdaten
SET tageserzeugung = 25.70
WHERE datum = '2022-05-03' AND idwindrad = 1007;

UPDATE betriebsdaten
SET tageserzeugung = 21.90
WHERE datum = '2022-05-03' AND idwindrad = 1008;

UPDATE betriebsdaten
SET tageserzeugung = 27.30
WHERE datum = '2022-05-03' AND idwindrad = 1009;

UPDATE betriebsdaten
SET tageserzeugung = 19.80
WHERE datum = '2022-05-03' AND idwindrad = 1010;

-- =========================================================
-- 5) OPTIONAL: EIN PAAR TESTABFRAGEN
-- =========================================================

-- Alle Windraeder eines Windparks
-- SELECT * FROM windrad WHERE idwindpark = 102;

-- Betriebsdaten eines bestimmten Tages
-- SELECT * FROM betriebsdaten WHERE datum = '2022-05-03';

-- Gesuchte Aufgabe
-- SELECT w.idwindrad
-- FROM windrad w
-- JOIN betriebsdaten b
--   ON w.idwindrad = b.idwindrad
-- WHERE w.idwindpark = 102
--   AND b.datum = '2022-05-03'
-- ORDER BY b.tageserzeugung DESC
-- LIMIT 3;

-- Kontrolle mit Leistung
-- SELECT w.idwindrad, b.tageserzeugung
-- FROM windrad w
-- JOIN betriebsdaten b
--   ON w.idwindrad = b.idwindrad
-- WHERE w.idwindpark = 102
--   AND b.datum = '2022-05-03'
-- ORDER BY b.tageserzeugung DESC;
