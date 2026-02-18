# Distribuciones Marso Website

The official website for **Distribuciones Marso**, a trusted beverage and hospitality products distributor based in Córdoba, Spain.

## About Distribuciones Marso

Distribuciones Marso specializes in distributing a wide range of beverages and hospitality products to restaurants and businesses across 9+ municipalities. With over 35 years of experience and 200+ satisfied customers, we pride ourselves on quality products at affordable prices.

**Tagline:** *Su distribuidor de confianza* (Your trusted distributor)

### Key Services

- 🍹 **Beverage Distribution** - Comprehensive selection of beverages for restaurants and retailers
- 🚚 **Reliable Delivery Service** - Custom delivery schedules tailored to your business needs
- 💰 **Quality & Value** - Premium products at competitive prices

## Technology Stack

- **Template Engine:** Mustache.js - For dynamic HTML generation from `template.json`
- **Frontend:** HTML5, CSS3, JavaScript
- **Icons:** FontAwesome
- **Development Server:** http-server
- **Code Formatting:** Prettier
- **Testing:** Node.js built-in test runner
- **Build Tool:** npm scripts

## Project Structure

```
marso_website/
├── index.template       # Mustache template for main page
├── template.json        # Configuration data for content and styling
├── index.html          # Generated HTML (output of build process)
├── css/                # Stylesheets
├── js/                 # JavaScript files
├── images/             # Logo, favicon, and brand assets
├── html/               # Additional HTML components
├── tests/              # Automated tests
├── BUSINESS_PROFILE.md # Business information and contact details
└── .github/workflows/  # CI/CD pipeline configuration
```

## Getting Started

### Installation

Clone the repository and install dependencies:

```bash
git clone https://github.com/germa89/marso_website.git
cd marso_website
npm install
```

### Development

Start a local development server with live reload:

```bash
npm start
```

This will open the website in your default browser at `http://localhost:8080`

Alternative development commands:

```bash
npm run dev      # Development server without opening browser
npm run serve    # Start server
```

### Building

Generate the HTML from the Mustache template:

```bash
npm run build-mustache
```

This processes `index.template` with data from `template.json` to create `index.html`.

### Testing

Run the test suite:

```bash
npm test
```

### Code Formatting

Format all code files to match the project's style:

```bash
npm run format
```

## Features

- **Responsive Design** - Mobile-friendly layout that works on all devices
- **SEO Optimized** - Structured metadata and semantic HTML
- **Contact Form** - Easy way for customers to reach out
- **Team Showcase** - Display company team members
- **Service Cards** - Highlight main offerings with icons
- **Analytics Integration** - Google Analytics tracking
- **Ad Support** - Google AdSense integration for monetization

## Editing Content

Most website content is managed through `template.json`:

- Update company information (address, email, phone)
- Modify service descriptions and titles
- Add or change service cards
- Update portfolio statistics
- Manage navigation links

After editing `template.json`, rebuild the HTML:

```bash
npm run build-mustache
```

## Contact Information

📧 **Email:** marsodistribuciones@gmail.com

📍 **Address:**
Polígono Industrial La Dehesa
Hinojosa del Duque
Córdoba 14270, España

🌐 **Website:** https://germa89.github.io/marso_website/

## License

ISC License - See the LICENSE file for details

## Author

**German Martinez Ayuso**
GitHub: [germa89](https://github.com/germa89)

---

For more detailed business information, see [BUSINESS_PROFILE.md](BUSINESS_PROFILE.md)
