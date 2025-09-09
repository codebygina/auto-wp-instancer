![Made with WSL2](https://img.shields.io/badge/Made%20with-WSL2-blue?logo=docker)
![License: GPLv3](https://img.shields.io/badge/License-GPLv3-blue.svg)
![Auto WP](https://img.shields.io/badge/WordPress-Auto%20Instance-green?logo=wordpress)

![CI](https://github.com/codebygina/auto-wp-instancer/actions/workflows/test.yml/badge.svg)
![ShellCheck Lint](https://github.com/codebygina/auto-wp-instancer/actions/workflows/lint.yml/badge.svg)

# 🚀 Auto WordPress Instance Creator
**Auto-WP** is a lightweight CLI tool that spins up isolated WordPress environments using Docker inside WSL2. Perfect for developers, theme builders, and plugin testers who want fast, disposable WordPress instances with zero setup hassle.

---

## ✨ Features

- 🔧 One-command WordPress setup
- 🐘 MySQL 8.0 + WordPress latest
- ⚙️ Auto-install with WP-CLI
- 👤 Preconfigured admin: `test / test`
- ✍️ 10 author users created automatically
- 🧹 Easy cleanup with `--delete` option
- 🐳 Docker-powered, WSL2-friendly

---

## 📦 Requirements

- WSL2 with Docker & Docker Compose installed
- WP-CLI available inside the WordPress container
- Bash shell (Linux, macOS, WSL2)
- Execution permission for the script

---

## 🚀 Usage

**Clone this repo**

First, clone this repository:

```bash
git clone https://github.com/codebygina/auto-wp-instancer.git
cd auto-wp-instancer
````

(Or you can copy `auto-wp.sh` into any folder and run it from there - just make sure Docker and WP-CLI are available)

**Make the script executable**

```bash
chmod +x auto-wp.sh
````

### Create a new WordPress instance

```bash
./auto-wp.sh instance_name [port]
````

**Example:**

```bash
./auto-wp.sh wp-test-1 8081
```

This will:

  - Create a folder `wp-test-1`
  - Start WordPress on `http://localhost:8081`
  - Install WordPress with admin credentials
  - Create 10 author users

### Delete a WordPress instance

```bash
./auto-wp.sh --delete instance_name
```

**Example:**

```bash
./auto-wp.sh --delete wp-test-1
```

This will:

  - Stop and remove Docker containers
  - Delete the instance folder

### Help

```bash
./auto-wp.sh --help
```

-----

## 🧠 Tips

  - Run multiple instances on different ports.
  - Your theme code lives in `wp-content/themes`.
  - Easily integrate Vite, Tailwind, or custom workflows.
  - Great for testing plugins, themes, or WP configurations.

-----

## 👩‍💻 Author

Built with ❤️ by Gina, https://codebygina.com

-----

## 📣 Contribute

Want to improve the script, add features, or report bugs? Feel free to open issues or submit pull requests. Let’s make WordPress dev faster for everyone.
