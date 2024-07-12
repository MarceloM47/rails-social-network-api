# Rails social network API
<br>

## You can also check the Wiki:
[Wiki](https://github.com/MarceloM47/rails-social-network-api/wiki)

<br>

## Installation


### Requirements

- Ruby 3.2.4
- Rails 7
- MongoDB

<br>

### Install

1. **Clone the repository:**
```bash
git clone https://github.com/MarceloM47/rails-social-network-api.git
cd rails-social-network-api
```

<br>

2. **Install dependencies:**

  ```bash
  bundle install
  ```

<br>

3. **Setup MongoDB Atlas URI:**

- Copy the example environment file:

```bash
cp .env.example .env
```
- Edit .env and set your MongoDB Atlas URI:

```bash
MONGODB_ATLAS_URI="mongodb+srv://<username>:<password>@<cluster-url>/<database-name>?retryWrites=true&w=majority&appName=your-app-name"
```

<br>

4. **Start the server:**

  ```bash
  rails s
  ```

- The API will be available at http://localhost:3100/api/v1

<br>

## License

[MIT](https://choosealicense.com/licenses/mit/)
