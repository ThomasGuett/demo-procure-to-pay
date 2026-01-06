CREATE EXTENSION IF NOT EXISTS vector;

CREATE TABLE items (id bigserial PRIMARY KEY, context TEXT, embedding vector(4096));

DO $$
BEGIN
    -- Check if the table exists
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.tables
        WHERE table_name = 'tech_inventory'
    ) THEN
        -- Create the table if it doesn't exist
        CREATE TABLE tech_inventory (
            id SERIAL PRIMARY KEY,
            name VARCHAR(255) NOT NULL,
            description TEXT NOT NULL,
            amount INTEGER NOT NULL,
            book_value DECIMAL(15, 2) NOT NULL,
            inventory VARCHAR(50) NOT NULL
        );

        -- Insert the 11 items
        INSERT INTO tech_inventory (name, description, amount, book_value, inventory) VALUES
            ('The Plug-in Pug', 'A wireless charging pad that also doubles as a dog toy. Perfect for charging your phone and your pet''s enthusiasm.', 5, 999.99, 'inventory 1'),
            ('Quantum Quiche Maker', 'A quantum computing device that calculates the perfect quiche recipe in nanoseconds.', 1, 1200000.00, 'inventory 1'),
            ('Wi-Fi Whisk', 'A whisk that connects to your router to ensure your breakfast is always within range of your network.', 10, 49.95, 'inventory 1'),
            ('Cloudy Coffee Maker', 'A coffee maker that streams your morning brew to the cloud for backup. (It also makes decent coffee.)', 2, 299.99, 'inventory 1'),
            ('Pixel Pudding', 'A dessert that stores 4K resolution images in its gelatin. Great for debugging your sweet tooth.', 3, 19.99, 'inventory 1'),
            ('Data Doughnut', 'A doughnut that encrypts your data into its glaze. Perfect for secure snack breaks.', 1, 500.00, 'inventory 1'),
            ('Nano Noodle', 'A noodle that can be programmed to perform basic coding tasks. (It also tastes like spaghetti.)', 7, 14.99, 'inventory 1'),
            ('Holo Hamburger', 'A holographic burger that projects a 3D meal to your kitchen. (No calories, just pixels.)', 1, 999.99, 'inventory 1'),
            ('Bit Biscotti', 'A cookie that doubles as a USB drive. Just plug it into your mouth for instant data transfer.', 4, 29.99, 'inventory 1'),
            ('Server Scone', 'A scone that runs a mini server. Ideal for baking up your own cloud infrastructure.', 1, 1000.00, 'inventory 1'),
            ('Macbook Pro 14 M4Pro 36GB RAM 512GB SSD', 'A developer machine primarily reserved for IT department', 1, 3500.00, 'inventory 1');
    END IF;
END $$;

DO $$
BEGIN
    -- Check if office_inventory exists and create it if not
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.tables
        WHERE table_name = 'office_inventory'
    ) THEN
        CREATE TABLE office_inventory (
            id SERIAL PRIMARY KEY,
            name VARCHAR(255) NOT NULL,
            description TEXT NOT NULL,
            amount INTEGER NOT NULL,
            book_value DECIMAL(15, 2) NOT NULL,
            inventory VARCHAR(50) NOT NULL
        );

        -- Insert the 10 office inventory items
        INSERT INTO office_inventory (name, description, amount, book_value, inventory) VALUES
            ('The Paperweight of Infinite Paper', 'A paperweight that never runs out of paper. Ideal for procrastination.', 1, 999.99, 'inventory 2'),
            ('Coffee Cup with a Side of Wi-Fi', 'A mug that connects to your router. Perfect for sipping coffee and streaming Netflix at the same time.', 5, 29.95, 'inventory 2'),
            ('The Desk Chair That Never Stops Moving', 'A chair that vibrates with the energy of your deadlines. (Also great for napping.)', 2, 1999.99, 'inventory 2'),
            ('The Printer That Prints in 3D (and 4D)', 'A printer that prints your documents, your dreams, and your regrets. (It also prints coffee.)', 1, 5000.00, 'inventory 2'),
            ('The Keyboard That Types Itself', 'A keyboard that types your emails, your thoughts, and your ex''s name. (It also types in cursive.)', 3, 499.99, 'inventory 2'),
            ('The Lamp That Illuminates Your Productivity', 'A lamp that shines brighter when you’re working. (It also dims when you’re scrolling social media.)', 4, 149.99, 'inventory 2'),
            ('The Meeting Room That Never Ends', 'A room that keeps your meetings going for hours. (It also has a built-in coffee machine.)', 1, 12000.00, 'inventory 2'),
            ('The Stapler That Staples Everything', 'A stapler that staples your papers, your patience, and your sanity. (It also staples your coffee cups.)', 5, 29.99, 'inventory 2'),
            ('The Calendar That Never Lies', 'A calendar that tells you when your deadlines are. (It also tells you when your coffee is ready.)', 2, 99.99, 'inventory 2'),
            ('The Chair That Talks Back', 'A chair that gives you advice on your work. (It also yells at you when you’re late.)', 1, 1999.99, 'inventory 2');
    END IF;
END $$;