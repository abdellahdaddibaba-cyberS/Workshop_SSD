from flask import Flask, request, jsonify
import logging

app = Flask(__name__)

# Configure logging
logging.basicConfig(level=logging.INFO)

# VULNERABILITY: Sensitive Data Exposure in logs (SAST should catch this)
@app.route('/inventory/reserve', methods=['POST'])
def reserve_stock():
    data = request.json
    product_id = data.get('product_id')
    user_details = data.get('user_details') # Contains sensitive info
    
    # Unsafe logging of user details
    logging.info(f"Reserving product {product_id} for user: {user_details}")
    
    return jsonify({"status": "reserved", "product_id": product_id})

if __name__ == '__main__':
    app.run(port=8006)
