from flask import Flask, request, jsonify
import sqlite3

app = Flask(__name__)

# VULNERABILITY: SQL Injection potential (SAST should catch this)
@app.route('/products')
def get_products():
    category = request.args.get('category')
    query = f"SELECT * FROM products WHERE category = '{category}'"
    
    # This is unsafe! bandit/semgrep should flag this.
    conn = sqlite3.connect('database.db')
    cursor = conn.cursor()
    cursor.execute(query)
    results = cursor.fetchall()
    return jsonify(results)

if __name__ == '__main__':
    app.run(port=8002)
