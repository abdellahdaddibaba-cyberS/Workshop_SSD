from flask import Flask, request, jsonify

app = Flask(__name__)

# VULNERABILITY: Insecure Transmission/Storage of Credit Card Data
@app.route('/pay', methods=['POST'])
def process_payment():
    payment_data = request.json
    card_number = payment_data.get('card_number')
    cvv = payment_data.get('cvv')
    
    # Simulating processing...
    # VULNERABILITY: Storing raw CVV/Card info (SAST should flag this pattern)
    with open('transactions.log', 'a') as f:
        f.write(f"Payment processed for card: {card_number}, CVV: {cvv}\n")
        
    return jsonify({"status": "success", "transaction_id": "TXN12345"})

if __name__ == '__main__':
    app.run(port=8004)
