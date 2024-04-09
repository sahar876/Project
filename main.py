from flask import Flask, request, jsonify

app = Flask(__name__)


@app.route('/')  # Home page route
def home():
    return "Welcome to the Social Media Scanner API. Use /check endpoint to scan social media websites."


@app.route('/check', methods=['POST'])  # Route to fetch social media links
def check_social_media():
    data = request.json
    data.get('name')

    links = fetch_social_media_links()

    return jsonify(links)


def fetch_social_media_links():
    links = {
        'Facebook': ['https://www.facebook.com/user1', 'https://www.facebook.com/user2'],
        'Linkedin': ['https://www.linkedin.com/in/user1', 'https://www.linkedin.com/in/user2'],
        'Instagram': ['https://www.instagram.com/user1', 'https://www.instagram.com/user2']
    }

    return links


if __name__ == '__main__':
    app.run(debug=True)
