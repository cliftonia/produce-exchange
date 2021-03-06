CREATE DATABASE produce;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(300),
    username VARCHAR(100),
    password_digest VARCHAR(400),
    address_line_1 VARCHAR(300),
    suburb VARCHAR(100),
    postcode INTEGER,
    lon float8,
    lat float8,
    availability VARCHAR(400),
    avatar TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE items (
    id SERIAL PRIMARY KEY,
    title VARCHAR(300),
    description TEXT,
    latitude float,
    longitude float,
    quantity numeric,
    unit VARCHAR(50),
    user_id INTEGER,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE RESTRICT
);

CREATE TABLE photos (
    id SERIAL PRIMARY KEY,
    item_id INTEGER,
    image_link TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    FOREIGN KEY (item_id) REFERENCES items (id) ON DELETE RESTRICT
);

CREATE TABLE offer_statuses (
    id SERIAL PRIMARY KEY,
    stage VARCHAR(100),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE offers (
    id SERIAL PRIMARY KEY,
    proposer_user_id INTEGER,
    proposer_item_id INTEGER,
    proposer_item_qty numeric,
    reviewer_user_id INTEGER,
    reviewer_item_id INTEGER,
    reviewer_item_qty numeric,
    meeting_point VARCHAR(200),
    meeting_point_suburb VARCHAR(200),
    status_id INTEGER,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    FOREIGN KEY (proposer_user_id) REFERENCES users (id) ON DELETE RESTRICT,
    FOREIGN KEY (reviewer_user_id) REFERENCES users (id) ON DELETE RESTRICT,
    FOREIGN KEY (proposer_item_id) REFERENCES items (id) ON DELETE RESTRICT,
    FOREIGN KEY (reviewer_item_id) REFERENCES items (id) ON DELETE RESTRICT,
    FOREIGN KEY (status_id) REFERENCES offer_statuses (id) ON DELETE RESTRICT
);

-- ALTER TABLE items ALTER COLUMN quantity TYPE numeric;
-- ALTER TABLE offers ALTER COLUMN proposer_item_qty TYPE numeric;
-- ALTER TABLE offers ALTER COLUMN reviewer_item_qty TYPE numeric;