# TassieTech Design Principles

TassieTech should feel local, calm, capable, and practical. The site is not a startup pitch deck or a generic AI-generated technology brand. It should feel like a Tasmanian team that solves real business and personal IT problems without fuss.

## Core Philosophy

The interface should reduce anxiety. Most visitors arrive because something is broken, risky, confusing, or needs to be planned properly. The design should make the next step obvious, avoid visual noise, and communicate that TassieTech is steady, local, and technically competent.

Prefer clarity over decoration. Use visual polish to make the site easier to scan and trust, not to show off. When a detail does not help someone choose a service, understand a process, or feel safer getting in touch, remove it.

## Visual Direction

Use a restrained brand system:

- Purple is the primary brand color.
- Teal can be used sparingly for positive action and support states.
- Yellow is reserved for small highlights only, not large surfaces.
- Red and green are reserved for urgency, risk, error, or success.
- Neutral surfaces should do most of the work.

Avoid AI-looking visual tropes:

- Heavy gradients.
- Decorative diagonal stripe overlays.
- Repeated glowing cards.
- Multiple competing accent colors in one section.
- Overly busy proof chips, badges, and benefit claims.

Keep the subtle square grid pattern only where it supports the IT/business feel and stays quiet.

## Typography

Typography should feel professional and readable rather than bubbly or heavy. Use lighter weights where possible and avoid making every label, button, and heading extra-bold.

Headings should be confident but not shouty. Body text should be plain, direct, and useful. On mobile, centered compositions are acceptable where they improve clarity, especially in hero sections and compact CTAs.

## Layout

Sections should have a clear job. Avoid showing the same services multiple times on the same page unless the framing is meaningfully different.

For split sections, edges should align. Image panels and adjacent text panels should feel intentionally paired, with matching top and bottom edges wherever practical.

Cards should be used for repeated items, forms, and discrete tools. Avoid turning every section into a card. When logo grids are used, logos should feel clean and credible rather than boxed into heavy containers.

## Calls To Action

Each page should have CTAs that match the visitor's intent:

- Business pages should lead to business support or project enquiries.
- Individual pages should lead to personal tech help or calling.
- Scam recovery pages should lead to scam recovery help.
- Contact pages should not link back to themselves from hero buttons.

When a CTA section appears at the bottom of a page, use one primary action unless the visitor truly needs to choose between distinct paths.

## Forms

The contact form should feel guided, not bureaucratic. Step labels should be simple and not introduce jargon. A compact progress indicator is preferable to text-heavy labels like "Need, Details, Issue, Send."

Urgent cases should always remind people to call as well as submit the form.

## Trust And Proof

Use proof sparingly and make each proof element distinct. Do not stack multiple generic proof rows around the same hero message. Better proof examples include a concise client logo section, a short testimonial, a clear process, or an FAQ that removes friction.

FAQ sections are valuable and should appear near major CTAs, especially on service, contact, and location pages.

## Mobile

Mobile should be centered, direct, and easy to act on. The header should keep a visible call path before the menu is opened. The mobile menu should avoid duplicated CTA groups and should merge contact actions into one clear "Get in contact" path.

## Implementation Rules

- Remove decorative gradients before adding new decoration.
- Use flat surfaces, subtle shadows, and spacing before borders or glow.
- Keep hit areas at least 40px.
- Use tabular numbers for dynamic or numeric content.
- Use `text-wrap: balance` for headings and `text-wrap: pretty` for long text.
- Avoid `transition: all`; transition only the properties that actually change.
- Use page-specific CTAs instead of the generic four-option CTA wherever visitor intent is already known.
