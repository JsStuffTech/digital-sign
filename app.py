from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)

# Default office status
office_status = "In Office"

@app.route('/')
def index():
    return render_template('index.html', status=office_status)

@app.route('/update', methods=['GET', 'POST'])
def update_status():
    global office_status
    if request.method == 'POST':
        office_status = request.form.get('status')
        return redirect(url_for('index'))
    return render_template('update.html')

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)