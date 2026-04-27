from flask import Flask, request, jsonify
import sqlite3

app = Flask(__name__)

# FIXED: Using parameterized queries to prevent SQL Injection
@app.route('/products')
def get_products():
    category = request.args.get('category')
    
    conn = sqlite3.connect('database.db')
    cursor = conn.cursor()
    
    # Use '?' placeholder instead of f-string
    query = "SELECT * FROM products WHERE category = ?"
    cursor.execute(query, (category,))
    
    results = cursor.fetchall()
    return jsonify(results)

if __name__ == '__main__':
    app.run(port=8002)
