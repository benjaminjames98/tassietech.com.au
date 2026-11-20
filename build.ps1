$ErrorActionPreference = "Stop"

$SiteUrl = "https://tassietech.com.au"
$Phone = "03 6449 4214"
$PhoneShort = "6449 4214"
$Email = "help@tassietech.com.au"
$Address = "7 Hamilton St, Latrobe"

function Add-Page {
  param(
    [string]$Path,
    [string]$Title,
    [string]$Description,
    [string]$Kicker,
    [string]$Heading,
    [string]$Intro,
    [string]$Content,
    [string]$Active = "",
    [string]$HeroClass = "compact",
    [string]$HeroImage = "",
    [string]$HeroPosition = "",
    [bool]$NoIndex = $false
  )

  $script:Pages += [pscustomobject]@{
    Path = $Path
    Title = $Title
    Description = $Description
    Kicker = $Kicker
    Heading = $Heading
    Intro = $Intro
    Content = $Content
    Active = $Active
    HeroClass = $HeroClass
    HeroImage = if ([string]::IsNullOrWhiteSpace($HeroImage)) { Get-HeroImage $Path } else { $HeroImage }
    HeroPosition = if ([string]::IsNullOrWhiteSpace($HeroPosition)) { Get-HeroPosition $Path } else { $HeroPosition }
    NoIndex = $NoIndex
  }
}

function Get-Prefix {
  param([string]$Path)
  if ([string]::IsNullOrWhiteSpace($Path)) { return "" }
  $depth = ($Path.Trim("/") -split "/").Count
  return ("../" * $depth)
}

function Get-Canonical {
  param([string]$Path)
  if ([string]::IsNullOrWhiteSpace($Path)) { return "$SiteUrl/" }
  return "$SiteUrl/$($Path.Trim('/'))/"
}

function Get-CanonicalPath {
  param([string]$Path)
  switch ($Path.Trim("/")) {
    "about-page" { return "about" }
    "emergency" { return "emergency-response" }
    default { return $Path }
  }
}

function Get-PageCanonical {
  param($Page)
  return Get-Canonical (Get-CanonicalPath $Page.Path)
}

function Get-HeroImage {
  param([string]$Path)
  switch ($Path.Trim("/")) {
    "" { return "assets/img/heroes/home.jpeg" }
    "about" { return "assets/img/heroes/aurora-cradle.jpg" }
    "about-page" { return "assets/img/heroes/aurora-cradle.jpg" }
    "individuals" { return "assets/img/heroes/aurora-cradle.jpg" }
    "scam-recovery" { return "assets/img/heroes/scam-recovery.jpg" }
    "services" { return "assets/img/heroes/office-services-1440.jpg" }
    "community-services" { return "assets/img/heroes/community-services.jpg" }
    "emergency" { return "assets/img/heroes/office-services-1440.jpg" }
    "emergency-response" { return "assets/img/heroes/office-services-1440.jpg" }
    "contact" { return "assets/img/heroes/contact.jpeg" }
    "careers" { return "assets/img/heroes/careers.jpg" }
    "areas-we-serve" { return "assets/img/heroes/burnie.webp" }
    "it-services-for-burnie" { return "assets/img/heroes/burnie.webp" }
    "it-services-for-deloraine" { return "assets/img/heroes/deloraine.jpg" }
    "it-services-for-devonport" { return "assets/img/heroes/devonport.jpg" }
    "it-services-for-latrobe" { return "assets/img/heroes/latrobe.jpg" }
    "it-services-for-port-sorell" { return "assets/img/heroes/port-sorell.jpg" }
    "it-services-for-sheffield" { return "assets/img/heroes/home.jpeg" }
    "it-services-for-ulverstone" { return "assets/img/heroes/ulverstone.jpeg" }
    "it-services-for-wynyard" { return "assets/img/heroes/burnie.webp" }
    "it-services-for-smithton" { return "assets/img/heroes/burnie.webp" }
    "it-services-for-zeehan" { return "assets/img/heroes/aurora-cradle.jpg" }
    "it-services-for-penguin" { return "assets/img/heroes/ulverstone.jpeg" }
    "it-services-for-queenstown" { return "assets/img/heroes/aurora-cradle.jpg" }
    "it-services-for-launceston" { return "assets/img/heroes/aurora-cradle.jpg" }
    "it-services-for-george-town" { return "assets/img/heroes/aurora-cradle.jpg" }
    "it-services-for-perth" { return "assets/img/heroes/aurora-cradle.jpg" }
    "it-services-for-campbell-town" { return "assets/img/heroes/aurora-cradle.jpg" }
    "it-services-for-st-helens" { return "assets/img/heroes/aurora-cradle.jpg" }
    "it-services-for-hobart" { return "assets/img/heroes/aurora-cradle.jpg" }
    "it-services-for-new-norfolk" { return "assets/img/heroes/aurora-cradle.jpg" }
    "it-services-for-sorell" { return "assets/img/heroes/aurora-cradle.jpg" }
    "it-services-for-kingston" { return "assets/img/heroes/aurora-cradle.jpg" }
    "it-services-for-huonville" { return "assets/img/heroes/aurora-cradle.jpg" }
    "it-services-tasmania" { return "assets/img/heroes/burnie.webp" }
    default { return "assets/img/heroes/home.jpeg" }
  }
}

function Get-HeroPosition {
  param([string]$Path)
  switch ($Path.Trim("/")) {
    "" { return "48% 0%" }
    "about" { return "53% 51%" }
    "about-page" { return "53% 51%" }
    "individuals" { return "53% 51%" }
    "scam-recovery" { return "50% 100%" }
    "services" { return "50% 0%" }
    "community-services" { return "50% 100%" }
    "emergency" { return "50% 0%" }
    "emergency-response" { return "50% 0%" }
    "contact" { return "49% 0%" }
    "careers" { return "54% 49%" }
    "areas-we-serve" { return "50% 30%" }
    "it-services-for-burnie" { return "50% 30%" }
    "it-services-for-deloraine" { return "48% 29%" }
    "it-services-for-devonport" { return "48% 49%" }
    "it-services-for-latrobe" { return "51% 22%" }
    "it-services-for-port-sorell" { return "50% 46%" }
    "it-services-for-sheffield" { return "49% 0%" }
    "it-services-for-ulverstone" { return "45% 32%" }
    "it-services-for-wynyard" { return "50% 30%" }
    "it-services-for-smithton" { return "50% 30%" }
    "it-services-for-zeehan" { return "53% 51%" }
    "it-services-for-penguin" { return "45% 32%" }
    "it-services-for-queenstown" { return "53% 51%" }
    "it-services-for-launceston" { return "53% 51%" }
    "it-services-for-george-town" { return "53% 51%" }
    "it-services-for-perth" { return "53% 51%" }
    "it-services-for-campbell-town" { return "53% 51%" }
    "it-services-for-st-helens" { return "53% 51%" }
    "it-services-for-hobart" { return "53% 51%" }
    "it-services-for-new-norfolk" { return "53% 51%" }
    "it-services-for-sorell" { return "53% 51%" }
    "it-services-for-kingston" { return "53% 51%" }
    "it-services-for-huonville" { return "53% 51%" }
    "it-services-tasmania" { return "50% 30%" }
    default { return "center 46%" }
  }
}

function Get-Icon {
  param([string]$Name)
  switch ($Name) {
    "manage" { return '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M4 6h16M4 12h16M4 18h10"/><path d="M18 15v6M15 18h6"/></svg>' }
    "secure" { return '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 3 5 6v6c0 4.4 2.8 7.5 7 9 4.2-1.5 7-4.6 7-9V6l-7-3Z"/><path d="m9 12 2 2 4-5"/></svg>' }
    "grow" { return '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M4 18 10 12l4 4 6-9"/><path d="M14 7h6v6"/></svg>' }
    "help" { return '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 18h.01"/><path d="M9.2 9a3 3 0 1 1 5.2 2c-.9.8-1.8 1.3-2.1 2.7"/><circle cx="12" cy="12" r="9"/></svg>' }
    "cloud" { return '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M7 18h10a4 4 0 0 0 0-8 6 6 0 0 0-11.5 2A3.5 3.5 0 0 0 7 18Z"/></svg>' }
    "people" { return '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.9"/><path d="M16 3.1a4 4 0 0 1 0 7.8"/></svg>' }
    default { return '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M5 12h14"/><path d="m13 6 6 6-6 6"/></svg>' }
  }
}

function ServiceCards {
@"
<section class="section">
  <div class="section-header center reveal">
    <span class="section-kicker">Manage. Secure. Grow.</span>
    <h2>Technology that works quietly in the background.</h2>
    <p>Practical support for the systems Tasmanian teams rely on every day.</p>
  </div>
  <div class="grid four">
    <article class="card lift reveal">
      <span class="icon">$(Get-Icon manage)</span>
      <h3>Managed IT Support</h3>
      <p>Helpdesk, devices, accounts, procurement, networks, and everyday business support.</p>
      <a class="text-link" href="{{root}}managed-it-support-tasmania/">Explore managed IT support</a>
    </article>
    <article class="card lift reveal">
      <span class="icon">$(Get-Icon cloud)</span>
      <h3>Microsoft 365 and Cloud</h3>
      <p>Email, Teams, SharePoint, OneDrive, permissions, and cleaner cloud workflows.</p>
      <a class="text-link" href="{{root}}microsoft-365-support-tasmania/">Explore Microsoft 365 support</a>
    </article>
    <article class="card lift reveal">
      <span class="icon">$(Get-Icon secure)</span>
      <h3>Cyber Security and Backups</h3>
      <p>Stronger accounts, safer devices, backup confidence, and calm incident response.</p>
      <a class="text-link" href="{{root}}cyber-security-tasmania/">Explore cyber security</a>
    </article>
    <article class="card lift reveal">
      <span class="icon">$(Get-Icon grow)</span>
      <h3>Websites, Networks and Projects</h3>
      <p>WordPress care, UniFi networks, migrations, cloud projects, and planned upgrades.</p>
      <a class="text-link" href="{{root}}wordpress-care-tasmania/">Explore websites and care</a>
    </article>
  </div>
  <div class="service-audience-links reveal" aria-label="Choose a general support path">
    <a class="button secondary" href="{{root}}services/">Business IT services</a>
    <a class="button secondary" href="{{root}}individuals/">IT help for individuals</a>
  </div>
</section>
"@
}

function WhyTassieTech {
@"
<section class="feature-band">
  <div class="section media-split">
    <div class="photo-panel reveal">
      <img src="{{root}}assets/img/community-900.jpg" alt="TassieTech supporting local Tasmanian business community" loading="lazy">
    </div>
    <div class="reveal">
      <span class="section-kicker">Why local matters</span>
      <h2>Local Tasmanian IT support. Not mainlanders with a local number.</h2>
      <p>We live and work here. Clients get plain-language advice from a Tasmanian team that understands local businesses, community services, and households.</p>
      <div class="stat-row">
        <div class="stat"><strong>98%+</strong><span>Issue solve rate.</span></div>
        <div class="stat"><strong>100%</strong><span>Tasmanian team.</span></div>
        <div class="stat"><strong>24/7</strong><span>Monitoring options.</span></div>
        <div class="stat"><strong>No fuss</strong><span>Clear advice.</span></div>
      </div>
    </div>
  </div>
</section>
"@
}

function GoogleMapSection {
  param(
    [string]$Title = "Visit TassieTech by appointment.",
    [string]$Text = "Our Latrobe base supports clients across North West Tasmania and remote support across the state."
  )
@"
<section class="section">
  <div class="map-embed-grid">
    <div class="reveal">
      <span class="section-kicker">Local base</span>
      <h2>$Title</h2>
      <p>$Text</p>
      <ul class="coverage-bullet-list">
        <li>Based in Latrobe.</li>
        <li>Supporting North West Tasmania.</li>
        <li>Remote support across Tasmania.</li>
        <li>Onsite visits where practical.</li>
        <li>Office visits by appointment.</li>
      </ul>
      <div class="button-row"><a class="button primary" href="tel:0364494214">Call $PhoneShort</a><a class="button secondary" href="{{root}}contact/">Contact TassieTech</a></div>
    </div>
    <div class="map-embed-panel reveal">
      <iframe title="Map showing TassieTech in Latrobe, Tasmania" src="https://www.google.com/maps?q=7%20Hamilton%20St%2C%20Latrobe%20TAS%207306&amp;output=embed" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
    </div>
  </div>
</section>
"@
}

function IntakeForm {
  param(
    [string]$Class = "",
    [string]$Intro = "Start with the path that best matches what is happening.",
    [string]$Heading = "Speak with a Tasmanian IT Expert"
  )
@"
<form class="form-card intake-form $Class reveal" data-contact-form data-step-form data-current-step="1" method="post" action="{{root}}contact-submit.php" accept-charset="UTF-8">
  <div class="honeypot-field" aria-hidden="true"><label>Website</label><input name="website" tabindex="-1" autocomplete="off"></div>
  <input type="hidden" name="formStartedAt" data-form-started-at>
  <input type="hidden" name="intent" data-contact-intent>
  <input type="hidden" name="submissionType" data-submission-type>
  <input type="hidden" name="businessRequestType" data-business-request-type>
  <div class="form-intro">
    <span class="section-kicker">Get IT help</span>
    <h2>$Heading</h2>
    <p>$Intro</p>
  </div>
  <div class="form-progress" aria-label="Form progress">
    <span data-step-indicator="1">Need</span>
    <span data-step-indicator="2">Details</span>
    <span data-step-indicator="3">Issue</span>
    <span data-step-indicator="4">Send</span>
  </div>
  <section class="form-step" data-form-step="1" aria-labelledby="intake-step-1">
    <h3 id="intake-step-1">What do you need?</h3>
    <fieldset class="field option-field">
      <legend class="sr-only">Choose what you need help with</legend>
      <div class="choice-grid path-choice-grid">
        <label class="choice-card path-choice-card"><input type="radio" name="intentChoice" value="business-support" required><span><strong>Business support</strong></span></label>
        <label class="choice-card path-choice-card"><input type="radio" name="intentChoice" value="personal" required><span><strong>Personal tech help</strong></span></label>
        <label class="choice-card path-choice-card urgent"><input type="radio" name="intentChoice" value="urgent" required><span><strong>Urgent issue</strong></span></label>
        <label class="choice-card path-choice-card"><input type="radio" name="intentChoice" value="project" required><span><strong>Plan a project</strong></span></label>
      </div>
    </fieldset>
    <div class="form-step-actions"><button class="button primary" type="button" data-step-next>Next</button></div>
  </section>
  <section class="form-step" data-form-step="2" aria-labelledby="intake-step-2" hidden>
    <h3 id="intake-step-2">Your details</h3>
    <div class="field"><label for="name">Name*</label><input id="name" name="name" required autocomplete="name"></div>
    <div class="field"><label for="email">Email*</label><input id="email" name="email" type="email" required autocomplete="email"></div>
    <div class="conditional-group" data-contact-section="business" hidden>
      <div class="field"><label for="businessName">Business name*</label><input id="businessName" name="businessName" autocomplete="organization" data-conditional-required></div>
    </div>
    <div class="form-step-actions"><button class="button secondary" type="button" data-step-prev>Back</button><button class="button primary" type="button" data-step-next>Next</button></div>
  </section>
  <section class="form-step" data-form-step="3" aria-labelledby="intake-step-3" hidden>
    <h3 id="intake-step-3">Tell us what is happening</h3>
    <div class="conditional-group" data-contact-section="individual" hidden>
      <div class="field"><label for="individualIssue">Outline of the issue*</label><textarea id="individualIssue" name="individualIssue" placeholder="What is happening, when did it start, and what have you already tried?" data-conditional-required></textarea></div>
    </div>
    <div class="conditional-group" data-contact-section="business-project" hidden>
      <div class="field"><label for="budgetRange">Budget range*</label><select id="budgetRange" name="budgetRange" data-conditional-required><option value="">Select a range</option><option>Under &#36;2,500</option><option>&#36;2,500 - &#36;7,500</option><option>&#36;7,500 - &#36;15,000</option><option>&#36;15,000 - &#36;30,000</option><option>&#36;30,000+</option><option>Not sure yet</option></select></div>
      <div class="field"><label for="projectOverview">Project overview*</label><textarea id="projectOverview" name="projectOverview" placeholder="What are you trying to build, improve, migrate, or fix? Include timing if there is a deadline." data-conditional-required></textarea></div>
    </div>
    <div class="conditional-group" data-contact-section="business-support" hidden>
      <div class="field"><label for="supportIssue">Outline of the issue*</label><textarea id="supportIssue" name="supportIssue" placeholder="What is affected, how many people are impacted, and when did it start?" data-conditional-required></textarea></div>
      <fieldset class="field option-field urgency-field">
        <legend>Urgency*</legend>
        <div class="choice-grid urgency-grid">
          <label class="choice-card"><input type="radio" name="urgency" value="critical" data-conditional-required><span><strong>Critical</strong><small>Operations stopped, suspected compromise, or data loss risk.</small></span></label>
          <label class="choice-card"><input type="radio" name="urgency" value="high" data-conditional-required><span><strong>High</strong><small>Multiple people affected or a key workflow blocked.</small></span></label>
          <label class="choice-card"><input type="radio" name="urgency" value="standard" data-conditional-required><span><strong>Standard</strong><small>Single-user issue, planned change, or non-urgent request.</small></span></label>
        </div>
      </fieldset>
    </div>
    <div class="form-step-actions"><button class="button secondary" type="button" data-step-prev>Back</button><button class="button primary" type="button" data-step-next>Next</button></div>
  </section>
  <section class="form-step" data-form-step="4" aria-labelledby="intake-step-4" hidden>
    <h3 id="intake-step-4">Send enquiry</h3>
    <div class="review-panel">
      <strong data-review-path>Choose a support path</strong>
      <span data-review-copy>We will route your enquiry to the right next step.</span>
    </div>
    <p class="form-note">If operations have stopped or data may be at risk, call <a href="tel:0364494214">$PhoneShort</a> as well as sending the form.</p>
    <div class="form-step-actions"><button class="button secondary" type="button" data-step-prev>Back</button><button class="button primary" type="submit">Send enquiry</button></div>
  </section>
  <p data-form-status aria-live="polite"></p>
</form>
"@
}

function CommunitySection {
@"
<section class="section">
  <div class="section-header center reveal">
    <span class="section-kicker">Community</span>
    <h2>Active in the business community we support.</h2>
    <p>Local relationships, professional standards, and practical security guidance shape the work.</p>
  </div>
  <div class="logo-cloud reveal">
    <article class="logo-pill"><img src="{{root}}assets/img/community/kaliba.png" alt="" width="197" height="197" loading="lazy" decoding="async"><strong>KaLIBA</strong><span>A Kentish and Latrobe business network that keeps us connected with local operators, events, and regional priorities.</span></article>
    <article class="logo-pill"><img src="{{root}}assets/img/community/dcci.png" alt="" width="274" height="274" loading="lazy" decoding="async"><strong>DCCI</strong><span>The Devonport Chamber of Commerce and Industry, supporting business connection, advocacy, and growth across the Devonport area.</span></article>
    <article class="logo-pill"><img src="{{root}}assets/img/community/asd.png" alt="" width="439" height="332" loading="lazy" decoding="async"><strong>ASD Partner</strong><span>Part of the Australian Signals Directorate cyber security partnership ecosystem, keeping our advice close to current ACSC guidance.</span></article>
    <article class="logo-pill"><img src="{{root}}assets/img/community/acs.png" alt="" width="271" height="300" loading="lazy" decoding="async"><strong>Australian Computer Society</strong><span>Australia's professional association for technology workers, supporting ICT standards, ethics, and ongoing professional development.</span></article>
  </div>
</section>
"@
}

function CtaPanel {
  param([string]$Title = "Speak directly with a local tech expert.", [string]$Text = "Tell us what is happening and we will help you choose the next practical step.")
@"
<section class="section tight">
  <div class="cta-panel intent-panel reveal">
    <div class="cta-copy">
      <h2>$Title</h2>
      <p>$Text</p>
    </div>
    <div class="intent-cta-grid" aria-label="Choose the right next step">
      <a class="intent-cta" href="{{root}}contact/?intent=business-support"><strong>Business support</strong></a>
      <a class="intent-cta" href="{{root}}contact/?intent=personal"><strong>Personal tech help</strong></a>
      <a class="intent-cta urgent" href="{{root}}contact/?intent=urgent"><strong>Urgent issue</strong></a>
      <a class="intent-cta" href="{{root}}contact/?intent=project"><strong>Plan a project</strong></a>
    </div>
  </div>
</section>
"@
}

function HomeTriageSection {
@"
<section class="section tight">
  <div class="section-header center reveal">
    <span class="section-kicker">Start here</span>
    <h2>What do you need help with?</h2>
    <p>Choose the path that best matches what is happening. We will collect the right details and point you to the next practical step.</p>
  </div>
  <div class="intent-cta-grid home-triage-grid reveal" aria-label="Choose your TassieTech support path">
    <a class="intent-cta" href="{{root}}contact/?intent=business-support"><strong>Business IT Support</strong><small>Managed IT, Microsoft 365, devices, accounts, networks, security, and staff support.</small></a>
    <a class="intent-cta" href="{{root}}contact/?intent=personal"><strong>Personal IT Help</strong><small>Computers, email, internet, scams, devices, passwords, and everyday technology issues.</small></a>
    <a class="intent-cta urgent" href="{{root}}emergency-response/"><strong>Urgent IT Issue</strong><small>Outages, suspected compromise, business disruption, or time-sensitive technology problems.</small></a>
    <a class="intent-cta" href="{{root}}contact/?intent=project"><strong>Plan a Project</strong><small>Websites, migrations, cloud systems, backups, networks, security, and system improvements.</small></a>
  </div>
</section>
"@
}

function HomeTrustSection {
@"
<section class="section">
  <div class="section-header center reveal">
    <span class="section-kicker">Trust signals</span>
    <h2>What clients rely on us to make simpler.</h2>
    <p>Good IT support should make everyday technology easier to trust, easier to explain, and easier to keep moving.</p>
  </div>
  <div class="grid three">
    <article class="card lift reveal">
      <h3>Fewer repeat IT problems</h3>
      <p>We look for the cause behind the ticket: unmanaged accounts, weak backups, unclear ownership, unreliable devices, or support habits that keep creating friction.</p>
    </article>
    <article class="card lift reveal">
      <h3>Clearer security decisions</h3>
      <p>Clients get plain-language priorities for MFA, password management, endpoint protection, backups, and recovery planning, without fear-based selling.</p>
    </article>
    <article class="card lift reveal">
      <h3>Local help that understands the work</h3>
      <p>Because we support Tasmanian businesses, community organisations, and individuals, the advice stays practical, local, and tied to how people actually use technology.</p>
    </article>
  </div>
</section>
"@
}

function HomeRecommendationsSection {
@"
<section class="section tight">
  <div class="section-header center reveal">
    <span class="section-kicker">Recommendations</span>
    <h2>Recommended next steps for Tasmanian IT support.</h2>
    <p>If you are not sure where to start, these are the most practical first moves for reducing risk, improving support, and making technology easier to manage.</p>
  </div>
  <div class="grid four">
    <article class="card lift reveal">
      <h3>Book an IT health check</h3>
      <p>Start with a plain-language review of accounts, devices, backups, Microsoft 365, security, and recurring support issues.</p>
      <a class="text-link" href="{{root}}contact/?intent=business-support">Book a health check</a>
    </article>
    <article class="card lift reveal">
      <h3>Secure accounts and backups</h3>
      <p>Prioritise MFA, password management, endpoint protection, backup coverage, and restore confidence before something fails.</p>
      <a class="text-link" href="{{root}}cyber-security-tasmania/">Review security support</a>
    </article>
    <article class="card lift reveal">
      <h3>Clean up Microsoft 365</h3>
      <p>Bring email, Teams, SharePoint, OneDrive, permissions, onboarding, and offboarding into a cleaner operating rhythm.</p>
      <a class="text-link" href="{{root}}microsoft-365-support-tasmania/">Review Microsoft 365 support</a>
    </article>
    <article class="card lift reveal">
      <h3>Choose your support model</h3>
      <p>Decide whether you need focused help for one issue, planned project work, or an ongoing managed IT partnership.</p>
      <a class="text-link" href="{{root}}services/">Compare business IT services</a>
    </article>
  </div>
</section>
"@
}

function FaqSection {
  param([object[]]$Faqs)
  if (-not $Faqs -or $Faqs.Count -eq 0) { return "" }

  $items = ($Faqs | ForEach-Object {
    $question = Encode-Html $_.Q
    $answer = Encode-Html $_.A
@"
    <details class="faq-item reveal">
      <summary>$question</summary>
      <p>$answer</p>
    </details>
"@
  }) -join "`n"

@"
<section class="section faq-section">
  <div class="section-header center reveal">
    <span class="section-kicker">Questions</span>
    <h2>Useful answers before we talk.</h2>
  </div>
  <div class="faq-list">
$items
  </div>
</section>
"@
}

function Register-Faq {
  param([string]$Path, [object[]]$Faqs)
  if ($Faqs -and $Faqs.Count -gt 0) {
    $script:FaqByPath[$Path] = $Faqs
  }
}

function Register-ServiceSchema {
  param(
    [string]$Path,
    [string]$Name,
    [string]$Description,
    [string]$ServiceType = "Business IT support",
    [string]$Area = "Tasmania"
  )

  $script:ServiceSchemaByPath[$Path] = [pscustomobject]@{
    Name = $Name
    Description = $Description
    ServiceType = $ServiceType
    Area = $Area
  }
}

function Get-IndividualServiceCards {
@"
<section class="section">
  <div class="section-header center reveal">
    <span class="section-kicker">Individual support</span>
    <h2>Choose the personal IT help you need.</h2>
    <p>Clear support for home devices, accounts, scams, internet issues, and everyday technology problems.</p>
  </div>
  <div class="grid three service-link-grid">
    <a class="card lift reveal" href="{{root}}individuals/"><h3>General IT Support</h3><p>Computers, laptops, email, Wi-Fi, routers, software, and accounts.</p></a>
    <a class="card lift reveal" href="{{root}}scam-recovery/"><h3>Scam Recovery</h3><p>Secure accounts, devices, personal information, and confidence after a scam.</p></a>
    <a class="card lift reveal" href="{{root}}contact/?intent=personal"><h3>Speak to a Local IT Expert</h3><p>Send the issue and we will point you to the safest next step.</p></a>
  </div>
</section>
"@
}

function Get-HighIntentServiceCards {
@"
<section class="section">
  <div class="section-header center reveal">
    <span class="section-kicker">Focused services</span>
    <h2>Focused support for common business IT needs.</h2>
    <p>Choose the service page that matches the system or risk you want to improve.</p>
  </div>
  <div class="grid three service-link-grid">
    <a class="card lift reveal" href="{{root}}managed-it-support-tasmania/"><h3>Managed IT Support</h3><p>Helpdesk, monitoring, device management, procurement, and practical support for daily work.</p></a>
    <a class="card lift reveal" href="{{root}}microsoft-365-support-tasmania/"><h3>Microsoft 365 Support</h3><p>Microsoft 365, Teams, SharePoint, OneDrive, security, and account governance.</p></a>
    <a class="card lift reveal" href="{{root}}cyber-security-tasmania/"><h3>Cyber Security</h3><p>MFA, password management, endpoint protection, security reviews, and incident readiness.</p></a>
    <a class="card lift reveal" href="{{root}}unifi-network-support-tasmania/"><h3>UniFi Network Support</h3><p>Business Wi-Fi, switching, firewall rules, VLANs, visibility, and practical network design.</p></a>
    <a class="card lift reveal" href="{{root}}wordpress-care-tasmania/"><h3>WordPress Care</h3><p>Website support, updates, hosting, backups, security, performance, and content changes.</p></a>
    <a class="card lift reveal" href="{{root}}backup-strategy-tasmania/"><h3>Backup Strategy</h3><p>Synology NAS, cloud backup, restore testing, retention, ransomware planning, and continuity.</p></a>
  </div>
</section>
"@
}

function Build-ServiceLandingContent {
  param($Service)

  $outcomes = ($Service.Outcomes | ForEach-Object { "<li>$_</li>" }) -join ""
  $stack = ($Service.Stack | ForEach-Object { "<li>$_</li>" }) -join ""
  $links = Get-HighIntentServiceCards
  $faq = FaqSection $Service.Faqs

@"
<section class="section">
  <div class="grid two">
    <div class="rich-text reveal">
      <span class="section-kicker">$($Service.Kicker)</span>
      <h2>$($Service.SectionHeading)</h2>
      <p>$($Service.Lead)</p>
      <p>$($Service.Supporting)</p>
    </div>
    <div class="card reveal">
      <h3>What good looks like</h3>
      <ul>$outcomes</ul>
    </div>
  </div>
</section>
<section class="feature-band alt">
  <div class="section">
    <div class="grid two">
      <div class="reveal">
        <span class="section-kicker">Stack fit</span>
        <h2>Built around technology we can support confidently.</h2>
        <p>$($Service.StackIntro)</p>
      </div>
      <div class="card reveal">
        <h3>Common systems</h3>
        <ul>$stack</ul>
      </div>
    </div>
  </div>
</section>
$links
$faq
$(CtaPanel $Service.CtaTitle $Service.CtaText)
"@
}

function StepsSection {
  param([string]$Title, [string]$One, [string]$Two, [string]$Three)
@"
<section class="section">
  <div class="section-header center reveal">
    <span class="section-kicker">How it works</span>
    <h2>$Title</h2>
  </div>
  <div class="grid three steps">
    <article class="card step reveal"><h3>Talk to a local</h3><p>$One</p></article>
    <article class="card step reveal"><h3>Get clear options</h3><p>$Two</p></article>
    <article class="card step reveal"><h3>Move forward</h3><p>$Three</p></article>
  </div>
</section>
"@
}

function AreasGrid {
@"
<section class="section">
  <div class="section-header center reveal">
    <span class="section-kicker">Areas we serve</span>
    <h2>Local IT support across Tasmania's North West and beyond.</h2>
    <p>Choose a town page or ask us about support in your area.</p>
  </div>
  <div class="service-path-grid area-link-grid reveal" aria-label="Tasmanian IT service area links">
    <a href="{{root}}it-services-for-burnie/">Burnie</a>
    <a href="{{root}}it-services-for-wynyard/">Wynyard</a>
    <a href="{{root}}it-services-for-smithton/">Smithton</a>
    <a href="{{root}}it-services-for-penguin/">Penguin</a>
    <a href="{{root}}it-services-for-queenstown/">Queenstown</a>
    <a href="{{root}}it-services-for-zeehan/">Zeehan</a>
    <a href="{{root}}it-services-for-devonport/">Devonport</a>
    <a href="{{root}}it-services-for-latrobe/">Latrobe</a>
    <a href="{{root}}it-services-for-ulverstone/">Ulverstone</a>
    <a href="{{root}}it-services-for-port-sorell/">Port Sorell</a>
    <a href="{{root}}it-services-for-sheffield/">Sheffield</a>
    <a href="{{root}}it-services-for-launceston/">Launceston</a>
    <a href="{{root}}it-services-for-deloraine/">Deloraine</a>
    <a href="{{root}}it-services-for-george-town/">George Town</a>
    <a href="{{root}}it-services-for-perth/">Perth</a>
    <a href="{{root}}it-services-for-campbell-town/">Campbell Town</a>
    <a href="{{root}}it-services-for-st-helens/">St Helens</a>
    <a href="{{root}}it-services-for-hobart/">Hobart</a>
    <a href="{{root}}it-services-for-new-norfolk/">New Norfolk</a>
    <a href="{{root}}it-services-for-sorell/">Sorell</a>
    <a href="{{root}}it-services-for-kingston/">Kingston</a>
    <a href="{{root}}it-services-for-huonville/">Huonville</a>
    <a href="{{root}}it-services-tasmania/">All Tasmania</a>
  </div>
</section>
"@
}

function ClientProofSection {
@"
<section class="client-proof" id="tasmania-businesses" aria-labelledby="tasmania-proof-heading">
  <div class="section">
    <div class="section-header center reveal">
      <span class="section-kicker">Client proof</span>
      <h2 id="tasmania-proof-heading">Trusted by Tasmanian organisations and larger teams.</h2>
      <p>Local clients, community organisations, retailers, and larger support environments rely on TassieTech for practical technology help.</p>
    </div>
    <div class="client-proof-stage reveal" aria-label="Local and larger client proof">
      <div class="client-logo-grid local-clients" aria-label="Some local TassieTech clients">
        <figure><img src="{{root}}assets/img/clients/bridgepro-engineering.png" alt="BridgePro Engineering website preview" loading="lazy" decoding="async"></figure>
        <figure><img src="{{root}}assets/img/clients/anvers-tasmania.png" alt="Anvers Tasmania website preview" loading="lazy" decoding="async"></figure>
        <figure><img src="{{root}}assets/img/clients/choice-support-plus.png" alt="Choice Support Plus website preview" loading="lazy" decoding="async"></figure>
        <figure><img src="{{root}}assets/img/clients/resolve-physio.png" alt="Resolve Physio website preview" loading="lazy" decoding="async"></figure>
        <figure><img src="{{root}}assets/img/clients/billing-cranes.png" alt="Billing Cranes website preview" loading="lazy" decoding="async"></figure>
        <figure><img src="{{root}}assets/img/clients/lighthouse.png" alt="Lighthouse website preview" loading="lazy" decoding="async"></figure>
        <figure><img src="{{root}}assets/img/clients/blank-designs.png" alt="bl_nk designs website preview" loading="lazy" decoding="async"></figure>
        <figure><img src="{{root}}assets/img/clients/integrate-workforce.png" alt="Integrate Workforce website preview" loading="lazy" decoding="async"></figure>
        <figure><img src="{{root}}assets/img/clients/nova-design-print.png" alt="Nova Design and Print website preview" loading="lazy" decoding="async"></figure>
        <figure><img src="{{root}}assets/img/clients/jag-digitising.png" alt="JAG Digitising website preview" loading="lazy" decoding="async"></figure>
        <figure><img src="{{root}}assets/img/clients/lemonthyme-wilderness-retreat.png" alt="Lemonthyme Wilderness Retreat website preview" loading="lazy" decoding="async"></figure>
        <figure><img src="{{root}}assets/img/clients/rhuby-delights.png" alt="Rhuby Delights logo" loading="lazy" decoding="async"></figure>
        <figure><img src="{{root}}assets/img/clients/elite-disability-care.png" alt="Elite Disability Care logo" loading="lazy" decoding="async"></figure>
      </div>
      <div class="brand-logo-strip" aria-label="Some larger clients TassieTech services">
        <figure><img src="{{root}}assets/img/clients/coles.png" alt="Coles logo" loading="lazy" decoding="async"></figure>
        <figure><img src="{{root}}assets/img/clients/woolworths.png" alt="Woolworths logo" loading="lazy" decoding="async"></figure>
        <figure><img src="{{root}}assets/img/clients/bws.png" alt="BWS logo" loading="lazy" decoding="async"></figure>
        <figure><img src="{{root}}assets/img/clients/europcar.png" alt="Europcar logo" loading="lazy" decoding="async"></figure>
        <figure><img src="{{root}}assets/img/clients/harvey-norman.png" alt="Harvey Norman logo" loading="lazy" decoding="async"></figure>
        <figure><img src="{{root}}assets/img/clients/kmart.png" alt="Kmart logo" loading="lazy" decoding="async"></figure>
        <figure><img src="{{root}}assets/img/clients/liquorland.png" alt="Liquorland logo" loading="lazy" decoding="async"></figure>
        <figure><img src="{{root}}assets/img/clients/cba.png" alt="Commonwealth Bank logo" loading="lazy" decoding="async"></figure>
      </div>
      <div class="client-proof-actions">
        <a class="button secondary" href="{{root}}areas-we-serve/">View service areas</a>
        <a class="button primary" href="{{root}}contact/?intent=business-support">Get business support</a>
      </div>
    </div>
  </div>
</section>
"@
}

function Encode-Html {
  param([string]$Text)
  if ([string]::IsNullOrWhiteSpace($Text)) { return "" }
  return [System.Net.WebUtility]::HtmlEncode($Text)
}

function Get-PlainText {
  param([string]$Html)
  if ([string]::IsNullOrWhiteSpace($Html)) { return "" }
  $text = $Html -replace '<script[\s\S]*?</script>', ' ' -replace '<style[\s\S]*?</style>', ' ' -replace '<[^>]+>', ' '
  $text = [System.Net.WebUtility]::HtmlDecode($text)
  return (($text -replace '\s+', ' ').Trim())
}

function Limit-Text {
  param([string]$Text, [int]$Length)
  if ([string]::IsNullOrWhiteSpace($Text) -or $Text.Length -le $Length) { return $Text }
  $cut = $Text.Substring(0, $Length)
  $lastSpace = $cut.LastIndexOf(" ")
  if ($lastSpace -gt 80) { $cut = $cut.Substring(0, $lastSpace) }
  return "$cut..."
}

function Format-BlogDate {
  param([string]$Date)
  return ([datetime]$Date).ToString("d MMM yyyy", [System.Globalization.CultureInfo]::InvariantCulture)
}

function Render-BlogCards {
  param($Posts)

  return (($Posts | ForEach-Object {
    $title = Encode-Html $_.title
    $category = Encode-Html $_.category
    $excerpt = Encode-Html (Limit-Text $_.excerpt 165)
    $date = Encode-Html (Format-BlogDate $_.date)
    $minutes = [int]$_.readingMinutes
    $image = $_.image
    $imageAlt = Encode-Html $_.imageAlt
@"
    <a class="card lift reveal blog-card" href="{{root}}$($_.slug)/">
      <img src="{{root}}$image" alt="$imageAlt" loading="lazy">
      <span class="tag">$category</span>
      <h3>$title</h3>
      <p>$excerpt</p>
      <span class="blog-card-meta">$date - $minutes min read</span>
    </a>
"@
  }) -join "`n")
}

function Add-RelatedLink {
  param($Links, [string]$Href, [string]$Title, [string]$Text)
  if (-not ($Links | Where-Object { $_.Href -eq $Href })) {
    [void]$Links.Add([pscustomobject]@{ Href = $Href; Title = $Title; Text = $Text })
  }
}

function Render-ArticleInternalLinks {
  param($Post)

  $links = [System.Collections.ArrayList]::new()
  $haystack = "$($Post.title) $($Post.category) $($Post.excerpt) $($Post.contentText)".ToLowerInvariant()

  if ($haystack -match "microsoft|365|sharepoint|onedrive|teams|outlook|email") {
    Add-RelatedLink $links "microsoft-365-support-tasmania/" "Microsoft 365 support" "Teams, SharePoint, OneDrive, Outlook, permissions, and secure account management."
  }
  if ($haystack -match "security|cyber|ransomware|malware|password|phishing|encryption|threat|breach|mfa|scam") {
    Add-RelatedLink $links "cyber-security-tasmania/" "Cyber security" "Practical account, device, password, backup, and incident-readiness support."
  }
  if ($haystack -match "backup|storage|nas|synology|restore|data loss|recovery") {
    Add-RelatedLink $links "backup-strategy-tasmania/" "Backup strategy" "Synology NAS, cloud backup, restore testing, retention, and continuity planning."
  }
  if ($haystack -match "network|wi-fi|wifi|router|iot|unifi|vlan|internet") {
    Add-RelatedLink $links "unifi-network-support-tasmania/" "UniFi network support" "Business Wi-Fi, segmentation, switching, visibility, and network troubleshooting."
  }
  if ($haystack -match "wordpress|website|hosting|web server|webserver") {
    Add-RelatedLink $links "wordpress-care-tasmania/" "WordPress care" "Website updates, hosting, backups, security, performance, and form delivery."
  }
  if ($haystack -match "device|laptop|desktop|hardware|procurement|productivity|support|office") {
    Add-RelatedLink $links "managed-it-support-tasmania/" "Managed IT support" "Helpdesk, devices, accounts, monitoring, and practical support for everyday work."
  }
  if ($haystack -match "scam|fraud") {
    Add-RelatedLink $links "scam-recovery/" "Scam recovery" "Calm local help to secure accounts, devices, and personal information after a scam."
  }

  Add-RelatedLink $links "business-it-support-tasmania/" "Business IT support" "A broader path for Tasmanian teams that need support, projects, and technology planning."
  Add-RelatedLink $links "recommended-technology-platform/" "Recommended technology platform" "The operating systems, productivity tools, security, cloud, and remote support stack we trust."
  Add-RelatedLink $links "areas-we-serve/" "Areas we serve" "Service coverage across Tasmanian towns and city hubs."

  $selected = $links
  $items = ($selected | ForEach-Object {
@"
    <a class="article-link-card" href="{{root}}$($_.Href)">
      <strong>$($_.Title)</strong>
      <span>$($_.Text)</span>
    </a>
"@
  }) -join "`n"

@"
<section class="section tight article-links-section">
  <div class="article-links reveal">
    <div>
      <span class="section-kicker">Related support</span>
      <h2>Where to go next</h2>
    </div>
    <div class="article-link-grid">
$items
    </div>
  </div>
</section>
"@
}

function Render-BlogArticle {
  param($Post)

  $category = Encode-Html $Post.category
  $date = Encode-Html (Format-BlogDate $Post.date)
  $minutes = [int]$Post.readingMinutes
  $content = $Post.contentHtml
  $ctaTitle = if ([string]::IsNullOrWhiteSpace($Post.ctaTitle)) { "Need practical help with this?" } else { $Post.ctaTitle }
  $ctaText = if ([string]::IsNullOrWhiteSpace($Post.ctaText)) { "Tell us what you are trying to solve and we will help turn it into clear next steps." } else { $Post.ctaText }

@"
<section class="section article-section">
  <article class="rich-text article-body reveal">
    <div class="article-meta">
      <span class="tag">$category</span>
      <span>$date</span>
      <span>$minutes min read</span>
    </div>
    $content
  </article>
</section>
$(Render-ArticleInternalLinks $Post)
$(CtaPanel $ctaTitle $ctaText)
"@
}

function Get-ArticleSchema {
  param($Page)

  $post = $BlogPosts | Where-Object { $_.slug -eq $Page.Path } | Select-Object -First 1
  if (-not $post) { return "" }

  $image = if ([string]::IsNullOrWhiteSpace($post.image)) { "$SiteUrl/assets/img/heroes/home.jpeg" } else { "$SiteUrl/$($post.image)" }
  $schema = [ordered]@{
    "@context" = "https://schema.org"
    "@type" = "BlogPosting"
    "headline" = $post.title
    "description" = $post.description
    "datePublished" = $post.date
    "dateModified" = "2026-05-15"
    "mainEntityOfPage" = (Get-Canonical $post.slug)
    "image" = @($image)
    "articleSection" = $post.category
    "author" = [ordered]@{
      "@type" = "Organization"
      "name" = "TassieTech"
      "url" = $SiteUrl
    }
    "publisher" = [ordered]@{
      "@type" = "Organization"
      "name" = "TassieTech"
      "logo" = [ordered]@{
        "@type" = "ImageObject"
        "url" = "$SiteUrl/assets/img/tassietech-logo.jpg"
      }
    }
  }
  $json = $schema | ConvertTo-Json -Depth 8 -Compress
  return "<script type=""application/ld+json"">$json</script>"
}

function Get-HomeSchema {
  param($Page)
  if (-not [string]::IsNullOrWhiteSpace($Page.Path)) { return "" }

  $schema = [ordered]@{
    "@context" = "https://schema.org"
    "@type" = @("LocalBusiness", "ProfessionalService")
    "@id" = "$SiteUrl/#business"
    "name" = "TassieTech"
    "url" = "$SiteUrl/"
    "logo" = "$SiteUrl/assets/img/tassietech-logo.jpg"
    "image" = "$SiteUrl/assets/img/heroes/home.jpeg"
    "description" = "Local Tasmanian IT support for managed IT, cyber security, Microsoft 365, backups, websites, networks, and practical technology advice."
    "telephone" = $Phone
    "email" = $Email
    "priceRange" = '$$'
    "address" = [ordered]@{
      "@type" = "PostalAddress"
      "streetAddress" = "7 Hamilton St"
      "addressLocality" = "Latrobe"
      "addressRegion" = "TAS"
      "addressCountry" = "AU"
    }
    "openingHoursSpecification" = @(
      [ordered]@{
        "@type" = "OpeningHoursSpecification"
        "dayOfWeek" = @("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")
        "opens" = "09:00"
        "closes" = "17:00"
      }
    )
    "areaServed" = @(
      [ordered]@{ "@type" = "AdministrativeArea"; "name" = "Tasmania" },
      [ordered]@{ "@type" = "City"; "name" = "Devonport" },
      [ordered]@{ "@type" = "City"; "name" = "Latrobe" },
      [ordered]@{ "@type" = "City"; "name" = "Burnie" },
      [ordered]@{ "@type" = "City"; "name" = "Wynyard" },
      [ordered]@{ "@type" = "City"; "name" = "Smithton" },
      [ordered]@{ "@type" = "City"; "name" = "Penguin" },
      [ordered]@{ "@type" = "City"; "name" = "Queenstown" },
      [ordered]@{ "@type" = "City"; "name" = "Zeehan" },
      [ordered]@{ "@type" = "City"; "name" = "Ulverstone" },
      [ordered]@{ "@type" = "City"; "name" = "Deloraine" },
      [ordered]@{ "@type" = "City"; "name" = "Port Sorell" },
      [ordered]@{ "@type" = "City"; "name" = "Sheffield" },
      [ordered]@{ "@type" = "City"; "name" = "George Town" },
      [ordered]@{ "@type" = "City"; "name" = "Perth" },
      [ordered]@{ "@type" = "City"; "name" = "Campbell Town" },
      [ordered]@{ "@type" = "City"; "name" = "Launceston" },
      [ordered]@{ "@type" = "City"; "name" = "St Helens" },
      [ordered]@{ "@type" = "City"; "name" = "Hobart" },
      [ordered]@{ "@type" = "City"; "name" = "New Norfolk" },
      [ordered]@{ "@type" = "City"; "name" = "Sorell" },
      [ordered]@{ "@type" = "City"; "name" = "Kingston" },
      [ordered]@{ "@type" = "City"; "name" = "Huonville" }
    )
    "hasOfferCatalog" = [ordered]@{
      "@type" = "OfferCatalog"
      "name" = "Tasmanian business IT services"
      "itemListElement" = @(
        [ordered]@{ "@type" = "Offer"; "itemOffered" = [ordered]@{ "@type" = "Service"; "name" = "Managed IT Support" } },
        [ordered]@{ "@type" = "Offer"; "itemOffered" = [ordered]@{ "@type" = "Service"; "name" = "Cyber Security" } },
        [ordered]@{ "@type" = "Offer"; "itemOffered" = [ordered]@{ "@type" = "Service"; "name" = "Microsoft 365 and SharePoint Support" } },
        [ordered]@{ "@type" = "Offer"; "itemOffered" = [ordered]@{ "@type" = "Service"; "name" = "Business Networks and UniFi Support" } },
        [ordered]@{ "@type" = "Offer"; "itemOffered" = [ordered]@{ "@type" = "Service"; "name" = "Websites, Hosting, and WordPress Support" } }
      )
    }
  }
  $json = $schema | ConvertTo-Json -Depth 10 -Compress
  return "<script type=""application/ld+json"">$json</script>"
}

function Get-ServiceSchema {
  param($Page)

  if (-not $ServiceSchemaByPath.ContainsKey($Page.Path)) { return "" }
  $service = $ServiceSchemaByPath[$Page.Path]
  $schema = [ordered]@{
    "@context" = "https://schema.org"
    "@type" = "Service"
    "@id" = "$(Get-PageCanonical $Page)#service"
    "name" = $service.Name
    "description" = $service.Description
    "serviceType" = $service.ServiceType
    "url" = (Get-PageCanonical $Page)
    "provider" = [ordered]@{
      "@type" = @("LocalBusiness", "ProfessionalService")
      "@id" = "$SiteUrl/#business"
      "name" = "TassieTech"
      "telephone" = $Phone
      "url" = "$SiteUrl/"
      "address" = [ordered]@{
        "@type" = "PostalAddress"
        "streetAddress" = "7 Hamilton St"
        "addressLocality" = "Latrobe"
        "addressRegion" = "TAS"
        "addressCountry" = "AU"
      }
    }
    "areaServed" = [ordered]@{
      "@type" = if ($service.Area -eq "Tasmania") { "AdministrativeArea" } else { "City" }
      "name" = $service.Area
      "addressRegion" = "TAS"
      "addressCountry" = "AU"
    }
    "offers" = [ordered]@{
      "@type" = "Offer"
      "url" = (Get-PageCanonical $Page)
      "availability" = "https://schema.org/InStock"
    }
  }
  $json = $schema | ConvertTo-Json -Depth 10 -Compress
  return "<script type=""application/ld+json"">$json</script>"
}

function Get-FaqSchema {
  param($Page)

  if (-not $FaqByPath.ContainsKey($Page.Path)) { return "" }
  $faqs = $FaqByPath[$Page.Path]
  if (-not $faqs -or $faqs.Count -eq 0) { return "" }

  $schema = [ordered]@{
    "@context" = "https://schema.org"
    "@type" = "FAQPage"
    "mainEntity" = @($faqs | ForEach-Object {
      [ordered]@{
        "@type" = "Question"
        "name" = $_.Q
        "acceptedAnswer" = [ordered]@{
          "@type" = "Answer"
          "text" = $_.A
        }
      }
    })
  }
  $json = $schema | ConvertTo-Json -Depth 10 -Compress
  return "<script type=""application/ld+json"">$json</script>"
}

function Get-PageTypeSchema {
  param($Page)

  if ($Page.NoIndex) { return "" }
  if ([string]::IsNullOrWhiteSpace($Page.Path)) { return "" }
  if ($BlogPosts | Where-Object { $_.slug -eq $Page.Path } | Select-Object -First 1) { return "" }
  if ($ServiceSchemaByPath.ContainsKey($Page.Path)) { return "" }

  $pageType = switch ($Page.Path.Trim("/")) {
    "about" { "AboutPage" }
    "contact" { "ContactPage" }
    "blog" { "CollectionPage" }
    default { "WebPage" }
  }

  $schema = [ordered]@{
    "@context" = "https://schema.org"
    "@type" = $pageType
    "@id" = "$(Get-PageCanonical $Page)#webpage"
    "url" = (Get-PageCanonical $Page)
    "name" = $Page.Title
    "description" = $Page.Description
    "isPartOf" = [ordered]@{
      "@type" = "WebSite"
      "@id" = "$SiteUrl/#website"
      "name" = "TassieTech"
      "url" = "$SiteUrl/"
    }
    "publisher" = [ordered]@{
      "@type" = "Organization"
      "@id" = "$SiteUrl/#business"
      "name" = "TassieTech"
    }
  }

  $json = $schema | ConvertTo-Json -Depth 8 -Compress
  return "<script type=""application/ld+json"">$json</script>"
}

function Get-HeroActions {
  param($Page, [string]$Prefix)

  if ($Page.Path -eq "emergency" -or $Page.Path -eq "emergency-response") {
@"
            <a class="button primary" href="tel:0364494214">Call $PhoneShort now</a>
            <a class="button secondary" href="${Prefix}contact/?intent=urgent">Report an urgent issue</a>
"@
  } elseif ([string]::IsNullOrWhiteSpace($Page.Path)) {
@"
            <a class="button primary" href="${Prefix}contact/">Get IT Help</a>
            <a class="button secondary" href="tel:0364494214">Call $PhoneShort</a>
"@
  } elseif ($Page.Active -eq "individuals") {
@"
            <a class="button primary" href="${Prefix}contact/?intent=personal">Get personal tech help</a>
            <a class="button secondary" href="tel:0364494214">Call $PhoneShort</a>
"@
  } elseif ($Page.Active -eq "services" -or $Page.Active -eq "areas") {
@"
            <a class="button primary" href="${Prefix}contact/?intent=business-support">Get business support</a>
            <a class="button secondary" href="${Prefix}contact/?intent=project">Plan an IT project</a>
"@
  } else {
@"
            <a class="button primary" href="${Prefix}contact/?intent=business-support">Get business support</a>
            <a class="button secondary" href="${Prefix}contact/?intent=urgent">Report an urgent issue</a>
"@
  }
}

$BlogPostsPath = Join-Path $PSScriptRoot "data/blog-posts.json"
$BlogPosts = if (Test-Path $BlogPostsPath) {
  Get-Content -Path $BlogPostsPath -Raw | ConvertFrom-Json
} else {
  @()
}

$Pages = @()
$FaqByPath = @{}
$ServiceSchemaByPath = @{}

$HighIntentServices = @(
  [pscustomobject]@{
    Slug = "managed-it-support-tasmania"
    Title = "Managed IT Support Tasmania | TassieTech"
    Description = "Managed IT support for Tasmanian businesses, including helpdesk, monitoring, Microsoft 365, devices, networks, security, backups, and practical advice."
    Kicker = "Managed IT"
    Heading = "Managed IT Support Tasmania"
    Intro = "Local business IT support that keeps devices, accounts, cloud systems, networks, and backups moving without making technology harder than it needs to be."
    SectionHeading = "Support that removes repeat IT friction."
    Lead = "Managed IT support should do more than wait for something to break. We help Tasmanian teams reduce recurring issues, standardise devices, manage accounts properly, and keep the everyday technology stack stable enough that people can focus on work."
    Supporting = "That can include helpdesk, monitoring, procurement advice, Microsoft 365 administration, endpoint protection, Splashtop remote access, backup checks, network support, and sensible documentation so your business is not reliant on one person remembering how everything works."
    StackIntro = "A good managed environment is consistent, documented, secure, and easy to support. We prefer practical systems that fit small and medium Tasmanian businesses rather than fragile one-off setups."
    Stack = @("Microsoft 365, Teams, SharePoint, OneDrive, and Outlook", "1Password for shared password management", "Splashtop for remote support where appropriate", "Synology NAS and cloud backup planning", "UniFi networking hardware for business Wi-Fi and switching")
    Outcomes = @("Staff know where to ask for help and what happens next.", "Devices, accounts, and access are easier to onboard and offboard.", "Security, backup, and support are built into daily operations.")
    CtaTitle = "Ready to make IT support predictable?"
    CtaText = "Tell us how your team works now and where support is getting messy. We will help map the simplest managed path forward."
    ServiceType = "Managed IT support"
    Faqs = @(
      @{ Q = "Do you only support businesses on managed agreements?"; A = "No. We can help with one-off support, projects, and managed arrangements. Managed support is best when a business wants ongoing helpdesk, monitoring, security, and continuity." },
      @{ Q = "Can you support remote teams outside the North West?"; A = "Yes. We are North West based, but many support tasks can be handled remotely across Tasmania with onsite work planned where it makes sense." },
      @{ Q = "Can you work with our existing Microsoft 365 tenant?"; A = "Yes. We can review the current setup, improve account governance, strengthen security, and support Teams, SharePoint, OneDrive, and Outlook." }
    )
  },
  [pscustomobject]@{
    Slug = "microsoft-365-support-tasmania"
    Title = "Microsoft 365 Support Tasmania | TassieTech"
    Description = "Microsoft 365 support in Tasmania for Teams, SharePoint, OneDrive, Outlook, email security, account management, MFA, permissions, and migrations."
    Kicker = "Microsoft 365"
    Heading = "Microsoft 365 Support Tasmania"
    Intro = "Microsoft 365, Teams, SharePoint, OneDrive, Outlook, and secure identity support for Tasmanian businesses that want collaboration without account chaos."
    SectionHeading = "Make Microsoft 365 easier to trust."
    Lead = "Microsoft 365 is powerful, but it becomes messy when accounts, permissions, Teams, SharePoint sites, OneDrive sync, and email security grow without a plan. We help businesses make the environment clearer, safer, and easier for staff to use."
    Supporting = "Typical work includes account setup, MFA, mailbox and calendar support, SharePoint structure, Teams tidy-up, file migration, permission reviews, backup strategy, phishing risk reduction, and onboarding or offboarding processes."
    StackIntro = "We work comfortably inside Microsoft's business ecosystem and pair it with the supporting controls that keep the environment maintainable."
    Stack = @("Microsoft 365 Business and Microsoft Entra identity basics", "Teams, SharePoint, OneDrive, Outlook, and Exchange Online", "MFA, conditional access planning, and secure account recovery", "1Password for shared secrets that should not live in spreadsheets", "Backup and retention planning for business-critical data")
    Outcomes = @("Files and permissions are easier for staff to understand.", "New starters and leavers are handled more cleanly.", "Email, identity, and collaboration risks are reduced.")
    CtaTitle = "Need Microsoft 365 cleaned up?"
    CtaText = "Send us what is frustrating your team: email, files, permissions, Teams, SharePoint, OneDrive, or account security."
    ServiceType = "Microsoft 365 support"
    Faqs = @(
      @{ Q = "Can you help migrate files into SharePoint or OneDrive?"; A = "Yes. We can plan the structure, migrate data, clean up permissions, and help staff understand the new workflow." },
      @{ Q = "Can you fix messy Teams and SharePoint permissions?"; A = "Yes. We can review existing groups, sites, access levels, external sharing, and ownership so permissions are easier to manage." },
      @{ Q = "Do we still need backup if files are in Microsoft 365?"; A = "Often, yes. Sync and retention are not the same as a tested backup strategy. We can help choose a sensible backup approach for the risk." }
    )
  },
  [pscustomobject]@{
    Slug = "cyber-security-tasmania"
    Title = "Cyber Security Tasmania | Practical Protection for Business"
    Description = "Cyber security support for Tasmanian businesses, including MFA, password management, endpoint protection, backup readiness, phishing risk, and response."
    Kicker = "Cyber security"
    Heading = "Cyber Security Tasmania"
    Intro = "Practical cyber security for Tasmanian businesses: stronger accounts, safer devices, clearer backups, and calm response when something looks wrong."
    SectionHeading = "Security that fits the way people actually work."
    Lead = "Cyber security does not need to be theatrical to be effective. The biggest gains often come from strengthening accounts, patching devices, using MFA, managing passwords properly, checking backups, and making sure staff know what to do when something feels wrong."
    Supporting = "We help with security reviews, endpoint protection, Microsoft 365 security basics, 1Password rollout, phishing and scam guidance, backup and restore planning, incident triage, and practical policies that staff can follow."
    StackIntro = "The goal is not to sell complexity. It is to make the everyday systems safer and easier to maintain."
    Stack = @("1Password for unique passwords and shared vaults", "Microsoft 365 security controls and account governance", "Endpoint protection and device patching", "Synology NAS and cloud backup planning", "UniFi segmentation for guest, IoT, and business networks")
    Outcomes = @("Accounts are harder to compromise.", "Backups are easier to trust during an incident.", "Staff know when to pause, report, and escalate.")
    CtaTitle = "Want a practical security review?"
    CtaText = "Tell us what systems your business relies on and we will help identify the highest-value security improvements first."
    ServiceType = "Cyber security support"
    Faqs = @(
      @{ Q = "Do you provide cyber security for small businesses?"; A = "Yes. Most of our security work is practical small-business protection: accounts, devices, backups, Microsoft 365, passwords, staff habits, and response planning." },
      @{ Q = "Can you help after a suspected compromise?"; A = "Yes. If operations have stopped, data may be at risk, or accounts may be compromised, call first so we can triage faster." },
      @{ Q = "Do you recommend password managers?"; A = "Yes. 1Password is part of our supported stack because unique passwords and shared vaults are more reliable than reused passwords or spreadsheets." }
    )
  },
  [pscustomobject]@{
    Slug = "unifi-network-support-tasmania"
    Title = "UniFi Network Support Tasmania | Business Wi-Fi and Networks"
    Description = "UniFi network support for Tasmanian businesses, including Wi-Fi, switching, firewall rules, VLANs, guest networks, visibility, and network troubleshooting."
    Kicker = "UniFi networks"
    Heading = "UniFi Network Support Tasmania"
    Intro = "Business Wi-Fi, switching, routing, segmentation, and troubleshooting for Tasmanian teams using or considering UniFi networking hardware."
    SectionHeading = "Networks should be visible, documented, and boring in the best way."
    Lead = "A good network lets staff work, guests connect safely, devices stay in the right place, and support issues become easier to diagnose. We help businesses move from consumer-grade uncertainty to a cleaner UniFi network design where appropriate."
    Supporting = "That can include Wi-Fi coverage, switch planning, firewall rules, VLANs, guest networks, IoT separation, remote visibility, documentation, firmware updates, and troubleshooting slow or unreliable connections."
    StackIntro = "UniFi is useful when configured properly. The value comes from design, segmentation, naming, updates, and visibility rather than the hardware alone."
    Stack = @("UniFi gateways, switches, access points, and controllers", "Guest Wi-Fi and segmented staff or device networks", "Firewall rules and practical VLAN planning", "Microsoft 365 and VoIP-aware network design", "Backup connectivity and continuity planning where needed")
    Outcomes = @("Staff and guests connect to the right network.", "Problem devices are easier to find and isolate.", "The network is documented enough to support confidently.")
    CtaTitle = "Need your network cleaned up?"
    CtaText = "Send us the site size, current equipment, and what is unreliable. We will help plan the next practical step."
    ServiceType = "Business network support"
    Faqs = @(
      @{ Q = "Do you only support UniFi networks?"; A = "No. We support a range of business networks, but UniFi is part of our preferred stack when it fits the site and budget." },
      @{ Q = "Can you separate guest Wi-Fi from business systems?"; A = "Yes. We can design guest networks, staff networks, and device networks so access is cleaner and safer." },
      @{ Q = "Can you troubleshoot poor Wi-Fi coverage?"; A = "Yes. We can review placement, signal issues, interference, roaming, and whether the network design matches the building." }
    )
  },
  [pscustomobject]@{
    Slug = "wordpress-care-tasmania"
    Title = "WordPress Care Tasmania | TassieTech"
    Description = "WordPress care for Tasmanian businesses, including updates, hosting, backups, security, performance, content support, and practical website improvements."
    Kicker = "WordPress care"
    Heading = "WordPress Care Tasmania"
    Intro = "WordPress support, hosting, updates, backups, performance, and security care for Tasmanian businesses that need their website to keep working."
    SectionHeading = "A business website should not be left to decay."
    Lead = "WordPress can be an excellent business platform when it is maintained. Problems usually appear when updates are ignored, plugins accumulate, backups are untested, hosting is slow, or nobody owns the ongoing care."
    Supporting = "We help with WordPress updates, hosting, backups, security hardening, performance improvements, content changes, forms, DNS, email deliverability, and practical improvements that support marketing rather than just keeping the site online."
    StackIntro = "WordPress sits best inside a wider supportable business technology stack: secure accounts, reliable hosting, backups, DNS control, and clear ownership."
    Stack = @("WordPress core, theme, and plugin maintenance", "Synergy Web Servers and suitable hosting arrangements", "Backup and restore checks", "Form delivery and DNS/email deliverability checks", "Microsoft 365 or Dropbox workflows for business content where appropriate")
    Outcomes = @("Updates are handled before they become urgent.", "Forms, hosting, backups, and security are easier to trust.", "The site can support marketing instead of quietly becoming a liability.")
    CtaTitle = "Want your WordPress site cared for properly?"
    CtaText = "Send us your website address and what you want to improve: reliability, security, speed, forms, content, or hosting."
    ServiceType = "WordPress website support"
    Faqs = @(
      @{ Q = "Can you maintain an existing WordPress site?"; A = "Yes. We can review the current setup, update safely, check backups, improve security, and recommend fixes without rebuilding unnecessarily." },
      @{ Q = "Can you help if forms are not delivering?"; A = "Yes. We can review the form setup, DNS records, mail delivery, and whether the webserver should send via authenticated SMTP." },
      @{ Q = "Do you build new WordPress sites?"; A = "Yes. We can support existing sites or plan new WordPress builds where WordPress is the right fit." }
    )
  },
  [pscustomobject]@{
    Slug = "backup-strategy-tasmania"
    Title = "Backup Strategy Tasmania | Business Continuity and Recovery"
    Description = "Backup strategy for Tasmanian businesses, including Synology NAS, cloud backup, retention, restore testing, ransomware planning, and continuity advice."
    Kicker = "Backups"
    Heading = "Backup Strategy Tasmania"
    Intro = "Backup and recovery planning for Tasmanian businesses that need confidence their files, systems, and cloud data can be restored when it matters."
    SectionHeading = "A backup is only useful if recovery works."
    Lead = "Many businesses assume sync is backup, or that a drive sitting onsite is enough. A stronger backup strategy separates collaboration from recovery, considers ransomware and accidental deletion, and tests whether important data can actually be restored."
    Supporting = "We help with backup design, Synology NAS planning, cloud backup, Microsoft 365 data considerations, retention, restore testing, documentation, and practical recovery steps for devices, servers, websites, and business files."
    StackIntro = "The right backup stack depends on how the business works, where data lives, and how quickly operations need to resume."
    Stack = @("Synology NAS for suitable local storage and backup workflows", "Cloud backup and offsite retention planning", "Microsoft 365, SharePoint, OneDrive, and Dropbox backup considerations", "WordPress and web hosting backup checks", "Restore testing and recovery documentation")
    Outcomes = @("Important data has a clear recovery path.", "Backup is separated from normal file sync.", "Restore testing becomes part of the support rhythm.")
    CtaTitle = "Can your business recover from data loss?"
    CtaText = "Tell us where your files, systems, and websites live. We will help identify the gaps between sync, backup, and real recovery."
    ServiceType = "Backup and recovery planning"
    Faqs = @(
      @{ Q = "Is Dropbox or OneDrive the same as backup?"; A = "No. Sync can be useful, but it is not always a complete backup strategy. Recovery planning needs retention, restore testing, and protection from accidental or malicious changes." },
      @{ Q = "Do you support Synology NAS devices?"; A = "Yes. Synology NASs are part of our stack where they fit the business need, especially for local storage, backup workflows, and continuity planning." },
      @{ Q = "Can you test whether our backups work?"; A = "Yes. Restore testing is one of the most important parts of backup planning because an untested backup is only an assumption." }
    )
  },
  [pscustomobject]@{
    Slug = "business-it-support-tasmania"
    Title = "Business IT Support Tasmania | TassieTech"
    Description = "Business IT support across Tasmania, including managed support, Microsoft 365, cyber security, backups, UniFi networks, WordPress care, and project help."
    Kicker = "Business support"
    Heading = "Business IT Support Tasmania"
    Intro = "Business IT support across Tasmania for teams that need practical help with devices, accounts, cloud systems, security, networks, websites, and continuity."
    SectionHeading = "One local team for the technology behind the work."
    Lead = "Small and medium businesses rarely need one isolated IT service. They need support that understands the full picture: staff devices, accounts, files, networks, websites, backups, remote access, and the way customers are served."
    Supporting = "TassieTech helps Tasmanian teams plan projects, solve support issues, improve security, and make day-to-day systems easier to run. We can work with businesses in our North West base and support teams remotely across Tasmania."
    StackIntro = "We reinforce a practical, supportable stack rather than chasing novelty for its own sake."
    Stack = @("Microsoft 365, Teams, SharePoint, and OneDrive", "1Password, Splashtop, Dropbox where suitable, and secure remote workflows", "Synology NAS, cloud backup, and recovery planning", "UniFi networking and business Wi-Fi support", "WordPress, hosting, and Synergy Web Servers where appropriate")
    Outcomes = @("Support requests have a clear path.", "Projects are planned around business outcomes.", "Security and continuity are considered before something fails.")
    CtaTitle = "Need business IT support in Tasmania?"
    CtaText = "Tell us whether this is a support issue or a project. The form will guide you to the right details."
    ServiceType = "Business IT support"
    Faqs = @(
      @{ Q = "Which parts of Tasmania do you support?"; A = "We are North West based and support Tasmanian businesses through remote support and planned onsite work where appropriate." },
      @{ Q = "Can you help with both support and projects?"; A = "Yes. The contact form separates business support requests from planned projects so we can triage the enquiry properly." },
      @{ Q = "Do you support businesses that already have some internal IT knowledge?"; A = "Yes. We can supplement internal capability with projects, specialist advice, documentation, or ongoing support." }
    )
  }
)

$homeContent = @"
$(ServiceCards)
$(ClientProofSection)
$(GoogleMapSection "Visit TassieTech's Latrobe base by appointment." "From our North West base, we support local onsite work where it makes sense and remote IT support across Tasmania.")
$(WhyTassieTech)
$(CommunitySection)
$(CtaPanel "Speak with a Tasmanian IT Expert" "Choose the right support path or call the Latrobe-based team.")
"@

Add-Page "" "Computer Support and IT Services Tasmania | TassieTech" "Local Tasmanian IT support for managed IT, cyber security, Microsoft 365, backups, websites, networks, and practical technology advice." "Friendly. Professional. Reliable." "IT Support in Tasmania" "Local IT experts who make technology simple for Tasmanian businesses, community organisations, and individuals." $homeContent "home" ""

$aboutContent = @"
<section class="section">
  <div class="grid two">
    <div class="rich-text reveal">
      <span class="section-kicker">Our story</span>
      <h2>Local heart, serious technical depth.</h2>
      <p>TassieTech is built around a simple belief: technology should make work easier, safer, and more productive. We are not here to overwhelm clients with jargon. We are here to pair the right technology with the right practical support.</p>
      <p>Our team brings experience across software development, websites, networks, cloud platforms, security, computer systems, and day-to-day support. That breadth matters because real IT problems rarely fit neatly inside one category.</p>
    </div>
    <div class="card reveal">
      <h3>What clients should feel</h3>
      <ul>
        <li>Friendly help from people who respect your time.</li>
        <li>Reliable follow-through and sensible advice.</li>
        <li>Professional standards without confusing language.</li>
        <li>Technology choices that fit local Tasmanian businesses.</li>
      </ul>
    </div>
  </div>
</section>
$(WhyTassieTech)
$(CommunitySection)
$(CtaPanel "Let's work together." "Tell us what you are trying to improve and we will help you find the right next step.")
"@
Add-Page "about" "About TassieTech | Local IT Experts Tasmania" "Meet TassieTech, a Tasmanian technology partner combining local care with professional IT, cyber security, software, web, and network expertise." "About TassieTech" "Discover TassieTech" "Where local heart meets global technology expertise." $aboutContent "about"

$individualContent = @"
<section class="section">
  <div class="section-header center reveal">
    <span class="section-kicker">General IT support</span>
    <h2>Computer, email, internet, and security help.</h2>
    <p>Talk to a local technician who can explain the fix clearly.</p>
  </div>
  <div class="grid three">
    <article class="card lift reveal"><span class="icon">$(Get-Icon help)</span><h3>Computers and laptops</h3><p>Slow devices, setup, repairs, data transfer, and troubleshooting.</p></article>
    <article class="card lift reveal"><span class="icon">$(Get-Icon cloud)</span><h3>Email and accounts</h3><p>Email setup, password issues, phone sync, and account security.</p></article>
    <article class="card lift reveal"><span class="icon">$(Get-Icon secure)</span><h3>Internet and security</h3><p>Router setup, Wi-Fi issues, malware checks, scams, and safer use.</p></article>
  </div>
</section>
<section class="feature-band alt">
  <div class="section">
    <div class="grid two">
      <div class="reveal"><span class="section-kicker">No fix, no fee</span><h2>Honest local IT help for individuals.</h2><p>Clear options, respectful support, and practical advice before you spend money.</p><div class="button-row"><a class="button primary" href="{{root}}contact/?intent=personal">Speak to a Local IT Expert</a></div></div>
      <div class="card reveal"><h3>Why people choose TassieTech</h3><ul><li>98%+ solve rate across IT fields.</li><li>Friendly local technicians.</li><li>Plain-language advice.</li><li>Business-grade experience for everyday problems.</li></ul></div>
    </div>
  </div>
</section>
$(Get-IndividualServiceCards)
<section class="section tight">
  <div class="section-header center reveal">
    <span class="section-kicker">Common problems</span>
    <h2>Find help for your device or issue.</h2>
  </div>
  <div class="service-path-grid reveal" aria-label="Personal IT help by device or issue">
    <a href="{{root}}computers/">Computer repairs</a>
    <a href="{{root}}laptops/">Laptop repairs</a>
    <a href="{{root}}pc/">PC repairs and upgrades</a>
    <a href="{{root}}windows/">Windows support</a>
    <a href="{{root}}mac/">Mac support</a>
    <a href="{{root}}virus-and-malware/">Virus and malware removal</a>
    <a href="{{root}}antivirus/">Antivirus setup</a>
    <a href="{{root}}email/">Email help</a>
    <a href="{{root}}internet-or-router-problems/">Internet and routers</a>
  </div>
</section>
$(CtaPanel "Speak to a Local IT Expert" "Call TassieTech today or send a quick message and we will point you in the right direction.")
"@
Add-Page "individuals" "General IT Support Tasmania | TassieTech Individuals" "Computer repairs, laptop help, email setup, internet and router support, antivirus, malware scans, and friendly local IT support in Tasmania." "For individuals" "Honest local IT help for individuals." "Call TassieTech for friendly, local support with computers, laptops, email, internet, security, and everyday technology problems." $individualContent "individuals"

$scamContent = @"
<section class="section">
  <div class="grid two">
    <div class="rich-text reveal">
      <span class="section-kicker">Recovery support</span>
      <h2>Rebuild confidence after a scam.</h2>
      <p>If you have been targeted by a scam, it can be hard to know who to trust or what to do first. TassieTech helps you take practical steps to protect your accounts, report what happened, and reduce the chance of further harm.</p>
      <ul><li>Listen to what happened without judgement.</li><li>Help you contact banks and relevant authorities.</li><li>Secure accounts, devices, and personal information.</li><li>Explain what is realistic and what is not.</li></ul>
    </div>
    <div class="card reveal">
      <h3>Our promise</h3>
      <p>No unrealistic guarantees. No upfront pressure. Just honest, privacy-conscious advice from local people focused on your safety.</p>
      <div class="button-row"><a class="button primary" href="tel:0364494214">Call $PhoneShort</a></div>
    </div>
  </div>
</section>
$(StepsSection "Simple, stress-free scam recovery in 3 steps." "Share what happened. You do not need technical language or perfect notes." "We outline immediate priorities and help you take action in the right order." "We help secure accounts, protect information, and reduce repeat risk.")
$(CommunitySection)
$(CtaPanel "Ready to speak to a local scam recovery team?" "Get calm, practical guidance from Tasmanian IT experts who respect your privacy.")
"@
Add-Page "scam-recovery" "Scam Recovery Tasmania | Local Help From TassieTech" "Local Tasmanian scam recovery support. Practical help to secure accounts, contact banks and authorities, protect personal information, and move forward safely." "Scam recovery" "Tasmanian Scam Recovery Experts" "Local, honest help when a scam has put your money, accounts, or confidence at risk." $scamContent "individuals"
Register-ServiceSchema "individuals" "General IT Support Tasmania" "Computer repairs, laptop help, email setup, internet and router support, antivirus, malware scans, and friendly local IT support in Tasmania." "General IT support" "Tasmania"
Register-ServiceSchema "scam-recovery" "Scam Recovery Tasmania" "Local Tasmanian scam recovery support for securing accounts, devices, personal information, and confidence after a scam." "Scam recovery support" "Tasmania"

$servicesContent = @"
<section class="feature-band">
  <div class="section">
    <div class="section-header center reveal">
      <span class="section-kicker">Business services</span>
      <h2>Choose your business IT path.</h2>
      <p>Start with the support area that best matches the job.</p>
    </div>
    <div class="service-path-grid reveal" aria-label="Business IT service paths">
      <a href="{{root}}business-it-support-tasmania/">Business IT support</a>
      <a href="{{root}}managed-it-support-tasmania/">Managed IT support</a>
      <a href="{{root}}microsoft-365-support-tasmania/">Microsoft 365 support</a>
      <a href="{{root}}cyber-security-tasmania/">Cyber security</a>
      <a href="{{root}}unifi-network-support-tasmania/">UniFi networks</a>
      <a href="{{root}}wordpress-care-tasmania/">WordPress care</a>
      <a href="{{root}}backup-strategy-tasmania/">Backup strategy</a>
      <a href="{{root}}care-packages/">IT care packages</a>
      <a href="{{root}}scale-your-business/">Scale your business</a>
      <a href="{{root}}emergency-response/">Emergency response</a>
    </div>
  </div>
</section>
$(ServiceCards)
<section class="section tight">
  <div class="grid two">
    <div class="rich-text reveal">
      <span class="section-kicker">Support model</span>
      <h2>Get Tasmanian business IT under control.</h2>
      <p>Choose focused help or a managed partnership. We can support your team, cloud systems, websites, phones, network, and security posture.</p>
    </div>
    <div class="card reveal">
      <h3>Best first steps</h3>
      <ul><li>Book a business IT health check.</li><li>Review Microsoft 365 and account security.</li><li>Confirm backups can actually restore.</li><li>Prioritise recurring support issues.</li></ul>
    </div>
  </div>
</section>
$(Get-HighIntentServiceCards)
$(CtaPanel "Get Tasmanian business IT under control." "Tell us what is slowing your team down. We will help you choose the most practical path.")
"@
Add-Page "services" "Business IT Services Tasmania | TassieTech" "Managed IT, cyber security, cloud, websites, networks, VOIP, custom software, and practical consulting for Tasmanian businesses." "Businesses" "Computer &amp; IT Services For Businesses In Tassie" "Managed support, security, consulting, cloud, websites, networks, phones, and software from a Tasmanian team." $servicesContent "services"

foreach ($service in $HighIntentServices) {
  $serviceContent = Build-ServiceLandingContent $service
  Add-Page $service.Slug $service.Title $service.Description $service.Kicker $service.Heading $service.Intro $serviceContent "services"
  Register-Faq $service.Slug $service.Faqs
  Register-ServiceSchema $service.Slug $service.Heading $service.Description $service.ServiceType "Tasmania"
}

$communityContent = @"
<section class="section">
  <div class="section-header center reveal">
    <span class="section-kicker">Community services</span>
    <h2>IT that lets your team focus on people.</h2>
    <p>Community service organisations handle sensitive information, staff onboarding, documents, devices, and critical day-to-day communication. TassieTech keeps that technology simple, secure, and maintained.</p>
  </div>
  <div class="grid four">
    <article class="card reveal"><h3>Microsoft 365</h3><p>Setup, management, secure collaboration, Teams, SharePoint, and account governance.</p></article>
    <article class="card reveal"><h3>Onboarding</h3><p>Fast employee onboarding and offboarding so access is clean, safe, and documented.</p></article>
    <article class="card reveal"><h3>Helpdesk</h3><p>Friendly remote and onsite support for staff who need clear answers.</p></article>
    <article class="card reveal"><h3>Cyber security</h3><p>Protection for sensitive client data, devices, backups, and user accounts.</p></article>
  </div>
</section>
$(StepsSection "Stress-free IT support in 3 steps." "Reach out for a quick chat about your organisation, team, and technology pain points." "We sort the best support options for your staff, systems, budget, and risk profile." "We manage and maintain the technology so your people can stay focused on the community.")
$(WhyTassieTech)
$(CtaPanel "Ready to simplify community services IT?" "Speak to a local team member or email community.services@tassietech.com.au.")
"@
Add-Page "community-services" "IT Support for Community Services Tasmania | TassieTech" "IT support for Tasmanian community service organisations, including Microsoft 365, secure documents, onboarding, helpdesk, backups, and cyber security." "Community services" "Hassle-Free IT for Community Services Organisations" "Let TassieTech handle your IT so you can focus on the people and communities you serve." $communityContent ""

$emergencyContent = @"
<section class="section">
  <div class="grid three">
    <article class="card reveal"><span class="icon">$(Get-Icon help)</span><h3>1. Triage</h3><p>We identify what is broken, what is at risk, and what needs immediate attention.</p></article>
    <article class="card reveal"><span class="icon">$(Get-Icon secure)</span><h3>2. Contain</h3><p>We help isolate the issue, protect accounts, preserve data, and stop the spread.</p></article>
    <article class="card reveal"><span class="icon">$(Get-Icon grow)</span><h3>3. Restore</h3><p>We get people working again and explain what should change to prevent repeat incidents.</p></article>
  </div>
</section>
<section class="feature-band alt">
  <div class="section media-split">
    <div class="reveal"><span class="section-kicker">When it cannot wait</span><h2>Urgent help for outages, security scares, and business disruption.</h2><p>Use this page when email is down, a device may be compromised, internet has failed, backups are in question, or your team is losing productive time.</p><div class="button-row"><a class="button primary" href="tel:0364494214">Call $PhoneShort now</a><a class="button secondary" href="{{root}}contact/">Send details</a></div></div>
    <div class="card reveal"><h3>Have this ready if you can</h3><ul><li>Business name and contact number.</li><li>What changed and when it started.</li><li>How many people or devices are affected.</li><li>Any messages, screenshots, or error codes.</li></ul></div>
  </div>
</section>
$(CtaPanel "Need urgent IT response?" "Call now, or send the fastest summary you can. We will help you prioritise the next action.")
"@
Add-Page "emergency-response" "Emergency IT Response Tasmania | TassieTech" "Urgent local IT help for business outages, suspected compromises, email failures, internet problems, device issues, and security incidents in Tasmania." "Emergency response" "Urgent IT help when business stops." "Fast triage, containment, and recovery support from a local Tasmanian technology team." $emergencyContent "services"
Add-Page "emergency" "Emergency IT Response Tasmania | TassieTech" "Urgent local IT help for business outages, suspected compromises, email failures, internet problems, device issues, and security incidents in Tasmania." "Emergency response" "Urgent IT help when business stops." "Fast triage, containment, and recovery support from a local Tasmanian technology team." $emergencyContent "services" "compact" "" "" $true
Register-ServiceSchema "services" "Business IT Services in Tasmania" "Managed support, security, consulting, cloud, websites, networks, phones, and software from a Tasmanian team." "Business IT services" "Tasmania"
Register-ServiceSchema "community-services" "IT Support for Community Services Tasmania" "Managed IT, Microsoft 365, secure documents, onboarding, helpdesk, backup, and cyber security support for Tasmanian community services organisations." "Community services IT support" "Tasmania"
Register-ServiceSchema "emergency-response" "Emergency IT Response Tasmania" "Urgent local IT help for business outages, suspected compromises, email failures, internet problems, device issues, and security incidents in Tasmania." "Emergency IT response" "Tasmania"
Register-ServiceSchema "emergency" "Emergency IT Response Tasmania" "Urgent local IT help for business outages, suspected compromises, email failures, internet problems, device issues, and security incidents in Tasmania." "Emergency IT response" "Tasmania"

# Pages carried over from the old WordPress site (now at old.tassietech.com.au) so their URLs keep working.
$IndividualHelpLinks = @(
  @{ Path = "computers"; Label = "Computer repairs" },
  @{ Path = "laptops"; Label = "Laptop repairs" },
  @{ Path = "pc"; Label = "PC repairs and upgrades" },
  @{ Path = "windows"; Label = "Windows support" },
  @{ Path = "mac"; Label = "Mac support" },
  @{ Path = "virus-and-malware"; Label = "Virus and malware removal" },
  @{ Path = "antivirus"; Label = "Antivirus setup" },
  @{ Path = "email"; Label = "Email help" },
  @{ Path = "internet-or-router-problems"; Label = "Internet and routers" },
  @{ Path = "scam-recovery"; Label = "Scam recovery" }
)

$BusinessHelpLinks = @(
  @{ Path = "best-managed-it-services-tasmania"; Label = "Managed IT services" },
  @{ Path = "care-packages"; Label = "IT care packages" },
  @{ Path = "business-security"; Label = "Business security" },
  @{ Path = "scale-your-business"; Label = "Scale your business" },
  @{ Path = "microsoft-365-support-tasmania"; Label = "Microsoft 365 support" },
  @{ Path = "backup-strategy-tasmania"; Label = "Backup strategy" },
  @{ Path = "unifi-network-support-tasmania"; Label = "UniFi networks" },
  @{ Path = "emergency-response"; Label = "Emergency response" }
)

function TestimonialCard {
  param([string]$Quote, [string]$Name)
  if ([string]::IsNullOrWhiteSpace($Quote)) { return "" }
@"
<figure class="card testimonial reveal">
  <span class="testimonial-stars" role="img" aria-label="5 out of 5 stars">&#9733;&#9733;&#9733;&#9733;&#9733;</span>
  <blockquote><p>&ldquo;$Quote&rdquo;</p></blockquote>
  <figcaption>$Name</figcaption>
</figure>
"@
}

function SingleCtaPanel {
  param([string]$Title, [string]$Text, [string]$Intent, [string]$Button)
@"
<section class="section tight">
  <div class="cta-panel reveal">
    <div class="cta-copy">
      <h2>$Title</h2>
      <p>$Text</p>
    </div>
    <div class="button-row"><a class="button primary" href="{{root}}contact/?intent=$Intent">$Button</a><a class="button secondary" href="tel:0364494214">Call $PhoneShort</a></div>
  </div>
</section>
"@
}

function Build-SupportPageContent {
  param($P, [object[]]$RelatedLinks)

  $problems = ($P.Problems | ForEach-Object { "    <article class=""card lift reveal""><h3>$($_.T)</h3><p>$($_.D)</p></article>" }) -join "`n"
  $why = ($P.Why | ForEach-Object { "<li>$_</li>" }) -join ""
  $related = ($RelatedLinks | Where-Object { $_.Path -ne $P.Slug } | ForEach-Object { "    <a href=""{{root}}$($_.Path)/"">$($_.Label)</a>" }) -join "`n"
  $testimonial = TestimonialCard $P.Quote $P.QuoteName
  $whyBlock = if ($testimonial) {
@"
    <div class="grid two">
      <div class="rich-text reveal"><span class="section-kicker">Why TassieTech</span><h2>$($P.WhyHeading)</h2><p>$($P.WhyText)</p><ul>$why</ul></div>
$testimonial
    </div>
"@
  } else {
@"
    <div class="grid two">
      <div class="rich-text reveal"><span class="section-kicker">Why TassieTech</span><h2>$($P.WhyHeading)</h2><p>$($P.WhyText)</p></div>
      <div class="card reveal"><h3>What you can expect</h3><ul>$why</ul></div>
    </div>
"@
  }

@"
<section class="section">
  <div class="section-header center reveal">
    <span class="section-kicker">$($P.ProblemsKicker)</span>
    <h2>$($P.ProblemsHeading)</h2>
    <p>$($P.ProblemsIntro)</p>
  </div>
  <div class="grid three">
$problems
  </div>
</section>
$(StepsSection $P.StepsTitle $P.Steps[0] $P.Steps[1] $P.Steps[2])
<section class="feature-band alt">
  <div class="section">
$whyBlock
  </div>
</section>
<section class="section tight">
  <div class="section-header center reveal">
    <span class="section-kicker">Related help</span>
    <h2>$($P.RelatedHeading)</h2>
  </div>
  <div class="service-path-grid reveal" aria-label="Related TassieTech services">
$related
  </div>
</section>
$(FaqSection $P.Faqs)
$(SingleCtaPanel $P.CtaTitle $P.CtaText $P.Intent $P.CtaButton)
"@
}

$IndividualWhy = @(
  "More than 98% of the IT problems we take on get solved.",
  "Local Tasmanian technicians, not a mainland call centre.",
  "You talk to the person doing the work, with no sales team in between.",
  "Plain-English explanations, and questions are always welcome."
)

$SupportPages = @(
  @{
    Slug = "computers"; Active = "individuals"; Intent = "personal"
    Title = "Computer Repairs and Support in Tasmania | TassieTech"
    Description = "Local computer repairs and IT support across Tasmania from Latrobe-based techs. Slow, broken, or virus-ridden computer? We fix it fast."
    Kicker = "Computer repairs"; Heading = "Computer Problems? Get Expert Help in Tasmania"
    Intro = "Quick computer repairs and support from local technicians, for the family desktop through to the work laptop."
    ProblemsKicker = "Whatever you use"; ProblemsHeading = "We repair and support every kind of computer."
    ProblemsIntro = "Choose the page that matches your computer, or tell us what is happening and we will work it out."
    Problems = @(
      @{ T = "<a href=""{{root}}laptops/"">Laptop repairs</a>"; D = "Batteries that will not hold a charge, cracked screens, overheating, and broken keyboards or hinges." },
      @{ T = "<a href=""{{root}}pc/"">PC repairs and upgrades</a>"; D = "Desktops that will not turn on, noisy or overheating towers, and SSD or RAM upgrades for older PCs." },
      @{ T = "<a href=""{{root}}windows/"">Windows support</a>"; D = "Windows 11 upgrades, failed updates, blue screens, and slow, crashing computers." },
      @{ T = "<a href=""{{root}}mac/"">Mac support</a>"; D = "MacBook, iMac, and Mac mini help, from macOS updates and iCloud to full storage and slow performance." },
      @{ T = "<a href=""{{root}}virus-and-malware/"">Viruses and malware</a>"; D = "Strange pop-ups, programs you did not install, and computers that suddenly slow to a crawl." },
      @{ T = "<a href=""{{root}}email/"">Email and accounts</a>"; D = "Email that will not send or sync, password problems, and accounts set up across your devices." }
    )
    StepsTitle = "How we fix your computer."
    Steps = @("Call or email us and explain the issue you are having with your computer.", "We diagnose the issue and explain how we plan to solve it and how long it will take.", "We fix the issue quickly so you can get back to using your computer problem-free.")
    WhyHeading = "Experienced computer repair experts."
    WhyText = "Whether your desktop is running slow, will not start up, or has a hardware fault, our techs have seen it all. We do individual and business IT support every day, and that breadth of experience benefits you whatever the problem."
    Why = $IndividualWhy
    Quote = "Tassie Tech have been servicing our computers now for several years, their service and advice has been well received around. They are local and provide a quality product."; QuoteName = "Graham"
    RelatedHeading = "More personal IT help."
    Faqs = @(
      @{ Q = "What does TassieTech help with?"; A = "We handle a wide range of computer issues, including slow systems, startup problems, hardware faults, software issues, and general troubleshooting for home and business users." },
      @{ Q = "Do you work with individuals as well as businesses?"; A = "Yes. Whether it is a personal laptop issue or ongoing business IT support, we apply the same level of expertise and care." },
      @{ Q = "Do you work on laptops, Macs, and Windows PCs?"; A = "Yes. We support every kind of computer. Our laptop repairs, PC repairs, Windows support, and Mac support pages have the details." },
      @{ Q = "Will I understand what you are doing to my computer?"; A = "Yes. We focus on clear, simple explanations so you understand the issue and the solution without technical jargon." },
      @{ Q = "How fast can you fix my issue?"; A = "It depends on the problem, but we always focus on fast turnaround and getting you back up and running as quickly as possible." }
    )
    CtaTitle = "Solve your computer problem today."; CtaText = "Tell us what your computer is doing and we will point you to the quickest fix."; CtaButton = "Fix my computer"
  },
  @{
    Slug = "windows"; Active = "individuals"; Intent = "personal"
    Title = "Windows Support and Windows 11 Upgrades in Tasmania | TassieTech"
    Description = "Windows 11 upgrades, failed updates, blue screens, and slow PCs fixed by local Tasmanian techs in Latrobe."
    Kicker = "Windows support"; Heading = "Windows Giving You Grief? Get Expert Help in Tasmania"
    Intro = "Upgrades, updates, and fixes for Windows 10 and Windows 11 from local technicians across Tasmania."
    ProblemsKicker = "Windows problems we fix"; ProblemsHeading = "Get Windows running smoothly again."
    ProblemsIntro = "Part of our <a href=""{{root}}computers/"">computer repairs</a> service, on desktops and laptops. For hardware faults, see <a href=""{{root}}pc/"">PC repairs</a> or <a href=""{{root}}laptops/"">laptop repairs</a>."
    Problems = @(
      @{ T = "Windows 11 upgrades"; D = "Microsoft has ended support for Windows 10. We check your computer against the <a href=""{{root}}minimum-hardware-requirements/"">minimum hardware requirements</a>, back up your files, and upgrade you to Windows 11." },
      @{ T = "Updates that will not install"; D = "Updates stuck, failing, or looping on restart. We get Windows up to date so you keep getting security fixes." },
      @{ T = "Blue screens and crashes"; D = "Blue screen errors, freezing, and random restarts are often drivers, failed updates, or software conflicts. We find the cause and fix it." },
      @{ T = "Slow start-up and performance"; D = "Too many start-up programs, bloatware, and full drives slow Windows down. We clean it up so it runs smoothly again." },
      @{ T = "Reset and reinstall"; D = "When Windows is beyond repair, we reinstall it cleanly and put your files and programs back. Suspect a virus? See <a href=""{{root}}virus-and-malware/"">virus and malware removal</a>." },
      @{ T = "Microsoft account, OneDrive, and Office"; D = "Sign-in problems, OneDrive sync issues, and Microsoft 365 setup, including Outlook and <a href=""{{root}}email/"">email</a>." }
    )
    StepsTitle = "How we sort it out."
    Steps = @("Call or email us and let us know what Windows is doing on your computer.", "We track down what is behind the problem and explain how we will fix it and how long it should take.", "We sort it out so Windows runs smoothly, stays updated, and stops getting in your way.")
    WhyHeading = "Experienced Windows technicians."
    WhyText = "Windows issues are a big part of our day. Stuck updates, blue screens, and sluggish start-ups are familiar territory, for home users and business IT support clients alike."
    Why = $IndividualWhy
    Quote = "Ben and the Tassie Tech crew were our go to for our computing needs in our local business. We were so pleased with the level of attention to detail, and the pricing was very competitive."; QuoteName = "Gordon"
    RelatedHeading = "More personal IT help."
    Faqs = @(
      @{ Q = "Is Windows 10 still supported?"; A = "No. Microsoft ended support for Windows 10 in October 2025, so it no longer gets regular security updates. We recommend upgrading to Windows 11, or replacing the computer if it cannot run it." },
      @{ Q = "Can my computer run Windows 11?"; A = "Check our minimum hardware requirements page, or let us check it for you." },
      @{ Q = "Will I lose my files if I upgrade to Windows 11?"; A = "No. We back up your files before upgrading and check everything is where it should be afterwards." },
      @{ Q = "Why do my Windows updates keep failing?"; A = "Common causes are a full drive, corrupted update files, or a driver conflict. We diagnose the cause and get updates installing again." },
      @{ Q = "What does a blue screen error mean?"; A = "It means Windows hit a problem it could not recover from, often a driver, update, or hardware fault. If it keeps happening, get it checked." },
      @{ Q = "Can you reinstall Windows for me?"; A = "Yes. We reinstall Windows cleanly, then restore your files, programs, and settings." }
    )
    CtaTitle = "Take the frustration out of Windows."; CtaText = "Tell us what Windows is doing and we will get it sorted."; CtaButton = "Fix my Windows problem"
  },
  @{
    Slug = "pc"; Active = "individuals"; Intent = "personal"
    Title = "PC Repairs and Upgrades in Tasmania | TassieTech"
    Description = "Desktop PC repairs and upgrades across Tasmania. PCs that will not start, overheating towers, SSD and RAM upgrades, and buying advice."
    Kicker = "PC repairs"; Heading = "PC Will Not Behave? Expert Repairs in Tasmania"
    Intro = "Desktop computer repairs and upgrades from local technicians across Tasmania."
    ProblemsKicker = "PC problems we fix"; ProblemsHeading = "Desktop towers and all-in-ones from every major brand."
    ProblemsIntro = "Part of our <a href=""{{root}}computers/"">computer repairs</a> service. Laptop trouble? See <a href=""{{root}}laptops/"">laptop repairs</a>."
    Problems = @(
      @{ T = "PCs that will not turn on"; D = "No power, no display, beeping, or a fan that spins with nothing on screen. We track down the faulty part, whether it is the power supply, memory, or motherboard." },
      @{ T = "Speed-up upgrades"; D = "Swapping an old hard drive for an SSD and adding memory is often the cheapest way to make a slow desktop feel new again." },
      @{ T = "Overheating and noisy towers"; D = "Dust-clogged fans and heatsinks cause loud fans, random shutdowns, and crashes. A clean-out and service fixes most of them." },
      @{ T = "Failing hard drives"; D = "Clicking noises, files that will not open, or a desktop stuck on start-up can mean a drive is failing. We back up what we can and replace the drive." },
      @{ T = "New desktop advice and setup"; D = "Not sure whether to repair or replace? We give honest advice, help you choose a new PC, and set it up with your files moved across." },
      @{ T = "Software and update issues"; D = "When the hardware is fine but Windows is not, our <a href=""{{root}}windows/"">Windows support</a> team takes over." }
    )
    StepsTitle = "How we get it fixed."
    Steps = @("Call or email us and describe what your PC is doing, or not doing.", "We test your desktop to pinpoint the faulty part, then talk you through the fix and the cost before we start.", "We repair or upgrade your PC and hand it back running the way it should.")
    WhyHeading = "Years of hands-on experience."
    WhyText = "Dead power supplies, failing drives, overheating towers, and constant crashes: we see desktop problems every day across home and business IT support, so there is very little we have not come across."
    Why = $IndividualWhy
    Quote = "Tassie Tech computers provide exceptional service in all areas. They have provided me with service, setup and support since I established my business and they continue to be my go to for support and advice."; QuoteName = "Eric"
    RelatedHeading = "More personal IT help."
    Faqs = @(
      @{ Q = "My PC will not turn on. Can you fix it?"; A = "Usually, yes. Most of the time it is a single faulty part, like the power supply, and we quote before replacing anything." },
      @{ Q = "Is it worth upgrading my old PC?"; A = "Often. An SSD and more memory can make a big difference for much less than a new computer. We will tell you honestly if it is not worth it." },
      @{ Q = "Why is my desktop so loud?"; A = "Dust build-up makes the fans work harder. A professional clean usually makes it quieter and cooler and helps it last longer." },
      @{ Q = "Can you get my files off a PC that will not start?"; A = "In many cases we can recover files from the drive of a computer that will not boot, and move them to your repaired or new PC." },
      @{ Q = "Can you help me choose a new PC?"; A = "Yes. We recommend a desktop that suits how you use it, then set it up and transfer your files." },
      @{ Q = "Do you fix all-in-one PCs?"; A = "Yes, along with standard desktop towers from all the major brands." }
    )
    CtaTitle = "Get your computer running again."; CtaText = "Describe what your PC is doing and we will work out the fix."; CtaButton = "Fix my PC"
  },
  @{
    Slug = "mac"; Active = "individuals"; Intent = "personal"
    Title = "Mac and MacBook Support in Tasmania | TassieTech"
    Description = "Local Mac support across Tasmania for MacBook, iMac, and Mac mini: macOS updates, iCloud, full storage, slow Macs, and moving from a PC."
    Kicker = "Mac support"; Heading = "Mac Not Working Right? Expert Help in Tasmania"
    Intro = "Help for MacBook Air, MacBook Pro, iMac, and Mac mini from local technicians across Tasmania."
    ProblemsKicker = "Mac problems we fix"; ProblemsHeading = "Fast, up to date, and working the way it should."
    ProblemsIntro = "Part of our <a href=""{{root}}computers/"">computer repairs</a> service."
    Problems = @(
      @{ T = "Slow performance"; D = "Spinning wheels, slow start-ups, and apps that take forever to open. We find what is slowing your Mac down and fix it." },
      @{ T = "macOS updates"; D = "Updates that will not install, or a Mac stuck on an old version. We check what your Mac can run and update it safely." },
      @{ T = "Storage full"; D = "Startup disk almost full? We clear out what you do not need and set up storage that works for you." },
      @{ T = "Apple ID and iCloud"; D = "iCloud setup, syncing photos and files between your Mac and iPhone, and Mail, Contacts, and Calendar setup." },
      @{ T = "Moving from a PC to a Mac"; D = "New to Mac? We move your files, photos, and email across from your old Windows PC and show you around." },
      @{ T = "Backups, pop-ups, and scams"; D = "Time Machine backups, plus help with suspicious pop-ups, adware, and scams. If you have been caught out, see <a href=""{{root}}scam-recovery/"">scam recovery</a>." }
    )
    StepsTitle = "From first call to fixed."
    Steps = @("Give us a call or send an email explaining what is going on with your Mac.", "We look into the issue, explain what we have found, and let you know how long the fix will take.", "We fix the problem so your Mac is fast, up to date, and working the way it should.")
    WhyHeading = "Experienced, friendly technicians."
    WhyText = "Slow MacBooks, full storage, update problems, and iCloud headaches are everyday jobs for our techs. Battery, screen, or keyboard trouble? We diagnose it and talk you through your repair options."
    Why = $IndividualWhy
    Quote = "I can not recommend Ben and the team highly enough."; QuoteName = "Brian"
    RelatedHeading = "More personal IT help."
    Faqs = @(
      @{ Q = "Which Macs do you work on?"; A = "MacBook Air, MacBook Pro, iMac, and Mac mini." },
      @{ Q = "My Mac says the startup disk is full. Can you help?"; A = "Yes. We work out what is taking up the space, safely clear what you do not need, and set up iCloud or external storage if it helps." },
      @{ Q = "Can you help me move from a Windows PC to a Mac?"; A = "Yes. We transfer your files, photos, and email and help you get comfortable with your new Mac." },
      @{ Q = "Can Macs get viruses?"; A = "It is less common than on Windows, but Macs can pick up adware, scam pop-ups, and malware. We can check and clean your Mac." },
      @{ Q = "Can my Mac run the latest macOS?"; A = "We check your model and let you know which version it can safely run." },
      @{ Q = "Can you set up Time Machine backups?"; A = "Yes. We set up automatic backups so your files are protected if anything goes wrong." }
    )
    CtaTitle = "Get expert Mac help today."; CtaText = "Tell us what your Mac is doing and we will get it sorted."; CtaButton = "Fix my Mac"
  },
  @{
    Slug = "laptops"; Active = "individuals"; Intent = "personal"
    Title = "Laptop Repairs in Tasmania | TassieTech"
    Description = "Local laptop repairs across Tasmania: batteries, screens, overheating, keyboards, and spills. All major brands. Latrobe-based techs."
    Kicker = "Laptop repairs"; Heading = "Laptop Issues? Local Experts in Tasmania Can Help"
    Intro = "Fast, reliable laptop repairs from local technicians across Tasmania."
    ProblemsKicker = "Laptop problems we fix"; ProblemsHeading = "HP, Dell, Lenovo, Acer, ASUS, Surface, and more."
    ProblemsIntro = "Part of our <a href=""{{root}}computers/"">computer repairs</a> service. Got a MacBook? See <a href=""{{root}}mac/"">Mac support</a>."
    Problems = @(
      @{ T = "Battery and charging problems"; D = "Batteries that drain fast, will not charge, or swell, plus loose or damaged charging ports and faulty chargers." },
      @{ T = "Cracked or faulty screens"; D = "Cracked, flickering, dim, or blank screens. We source the right replacement screen for your model and quote before we start." },
      @{ T = "Overheating and noisy fans"; D = "Laptops that run hot, shut down by themselves, or sound like a jet engine. A clean-out and service usually brings them back to normal." },
      @{ T = "Keyboards, trackpads, and hinges"; D = "Sticky or missing keys, trackpads that will not respond, and hinges that are loose or broken." },
      @{ T = "Spills and drops"; D = "Coffee on the keyboard or a fall off the desk? Turn the laptop off, do not charge it, and get in touch as soon as you can." },
      @{ T = "Slow or ageing laptops"; D = "A faster SSD and more memory can make an older laptop feel new again. For software problems, see <a href=""{{root}}windows/"">Windows support</a>." }
    )
    StepsTitle = "How we get you sorted."
    Steps = @("Call or email us and tell us what is going on with your laptop.", "We work out what is causing the problem, then explain the fix, the cost, and how long it will take.", "Your laptop comes back working properly, so you can get on with work, study, or streaming.")
    WhyHeading = "Experienced repair technicians."
    WhyText = "We have seen just about every laptop fault there is, from flat batteries and overheating to cracked screens and broken hinges. Because we handle home and business IT support every day, you get the benefit of that experience whatever has gone wrong."
    Why = $IndividualWhy
    Quote = "Ben and Jason have been such an asset to have on the external team of our business. They get the job done at a fair price and have the knowledge to provide the right advice. Can't recommend enough!"; QuoteName = "Mark"
    RelatedHeading = "More personal IT help."
    Faqs = @(
      @{ Q = "Can you replace my laptop battery?"; A = "For most models, yes. We confirm the right part and cost with you before any work starts." },
      @{ Q = "Can you fix a cracked laptop screen?"; A = "In most cases. We check your exact model, source a matching screen, and give you a quote first." },
      @{ Q = "Why is my laptop overheating?"; A = "Usually dust build-up inside or dried-out thermal paste. A clean and service normally fixes it and helps your laptop last longer." },
      @{ Q = "I spilled something on my laptop. What should I do?"; A = "Turn it off straight away, unplug it, and do not try to switch it back on. Then call us on 03 6449 4214. The sooner we see it, the better the chance of saving it." },
      @{ Q = "Is my old laptop worth repairing?"; A = "We will tell you honestly. If a repair costs more than the laptop is worth, we will say so and help you choose a replacement." },
      @{ Q = "How long do repairs take?"; A = "It depends on the problem and parts, but we focus on fast turnaround and keep you updated the whole way." }
    )
    CtaTitle = "Book your laptop repair today."; CtaText = "Tell us what is wrong and we will confirm the fix and the cost before we start."; CtaButton = "Fix my laptop"
  },
  @{
    Slug = "virus-and-malware"; Active = "individuals"; Intent = "personal"
    Title = "Virus and Malware Removal in Tasmania | TassieTech"
    Description = "Computer acting strange? Local techs find and remove viruses, malware, and ransomware from PCs and Macs across Tasmania."
    Kicker = "Virus and malware removal"; Heading = "Virus or Malware? Get a Security Scan in Tasmania"
    Intro = "Professional virus removal and malware protection to keep Tasmanian computers safe and secure."
    ProblemsKicker = "Signs of trouble"; ProblemsHeading = "We know where threats hide and how to remove them."
    ProblemsIntro = "From simple adware to serious ransomware, on Windows PCs and Macs."
    Problems = @(
      @{ T = "Strange pop-ups"; D = "Pop-ups, fake warnings, and browser pages you did not ask for are a common sign of adware or malware." },
      @{ T = "Programs you did not install"; D = "New toolbars, apps, or browser extensions that appeared on their own. We find them and remove them completely." },
      @{ T = "Sudden slow performance"; D = "A computer that suddenly slows to a crawl can be running something it should not. We scan, clean, and check it properly." },
      @{ T = "Ransomware and locked files"; D = "Files that will not open or a ransom message on screen. Stop using the computer and call us straight away." },
      @{ T = "Protection afterwards"; D = "Once it is clean, we make sure the right <a href=""{{root}}antivirus/"">antivirus</a> is installed and set up properly." },
      @{ T = "Scams and stolen details"; D = "If someone has had access to your computer or accounts, our <a href=""{{root}}scam-recovery/"">scam recovery</a> help secures them." }
    )
    StepsTitle = "How we clean your computer."
    Steps = @("Let us know what issues you are experiencing with your device.", "We detect, remove, and resolve malware or virus infections.", "Your system is cleaned and protected for safer everyday use.")
    WhyHeading = "Experienced virus and malware removal experts."
    WhyText = "We work across individual and <a href=""{{root}}business-security/"">business security</a> environments every day. We treat your devices and your data with respect, and we explain what we found, how we cleaned it, and how to stay safe going forward."
    Why = $IndividualWhy
    Quote = "Being a business, I was so pleased that they were willing to help me the same day I realised I had been hacked. They came that day and took the computer away and next morning bought it back all fixed and have had no problems since."; QuoteName = "Vicki"
    RelatedHeading = "More personal IT help."
    Faqs = @(
      @{ Q = "How do I know if my computer has a virus?"; A = "Common signs are strange pop-ups, programs you did not install, browser pages changing on their own, and a computer that suddenly runs slowly. If something feels wrong, get it scanned." },
      @{ Q = "Can you remove ransomware?"; A = "We can remove the infection and work out what can be recovered. Turn the computer off, do not pay the ransom, and call us as soon as you can." },
      @{ Q = "Do you remove viruses from Macs too?"; A = "Yes. Macs can pick up adware, scam pop-ups, and malware, and we can check and clean them." },
      @{ Q = "How do I stop it happening again?"; A = "We make sure your computer is updated and has the right antivirus set up properly, and we explain what to look out for." }
    )
    CtaTitle = "Scan and remove viruses today."; CtaText = "Tell us what your computer is doing and we will check it properly."; CtaButton = "Scan for viruses"
  },
  @{
    Slug = "email"; Active = "individuals"; Intent = "personal"
    Title = "Email Setup and Support in Tasmania | TassieTech"
    Description = "Email not sending, syncing, or set up properly? We fix email for homes and businesses across Tasmania."
    Kicker = "Email help"; Heading = "Email Not Working? Get IT Help in Tasmania"
    Intro = "Reliable email setup, troubleshooting, and support for individuals and businesses in Tasmania."
    ProblemsKicker = "Email problems we fix"; ProblemsHeading = "Email that works on every device, whatever the provider."
    ProblemsIntro = "Tell us what is going wrong or what you need set up."
    Problems = @(
      @{ T = "Emails that will not send"; D = "Messages stuck in the outbox, bounce-backs, and errors when you press send." },
      @{ T = "Syncing across devices"; D = "Email, contacts, and calendars that do not match between your computer, phone, and tablet." },
      @{ T = "Login and password issues"; D = "Locked out of your email, forgotten passwords, and accounts that keep asking you to sign in." },
      @{ T = "New email setup"; D = "A new address, a new device, or a move to a new provider, set up properly from the start." },
      @{ T = "Outlook and Microsoft 365"; D = "Outlook problems, OneDrive, and Microsoft account sign-in. See also <a href=""{{root}}windows/"">Windows support</a>." },
      @{ T = "Business email"; D = "For business email systems and Microsoft 365, see <a href=""{{root}}microsoft-365-support-tasmania/"">Microsoft 365 support</a>." }
    )
    StepsTitle = "How email support works."
    Steps = @("Tell us what is going wrong with your email or what you need help setting up or accessing.", "We diagnose and resolve setup problems, syncing errors, login issues, or missing email functionality.", "Your email is fixed and working properly so you can communicate without ongoing issues.")
    WhyHeading = "Experienced email support experts."
    WhyText = "Whether you need a new email set up, your accounts synced across devices, or you are stuck with emails that just will not send, our techs deal with email issues every day. We make sure you understand how your email is set up and how to use it with confidence."
    Why = $IndividualWhy
    Quote = "Absolute pleasure to work with, very friendly, fast, reliable and well priced. Highly recommend if you need any sort of computer, phone or IT help!"; QuoteName = "Kianie"
    RelatedHeading = "More personal IT help."
    Faqs = @(
      @{ Q = "Which email providers do you support?"; A = "We help with the common providers people use at home and at work, including Outlook and Microsoft 365, Gmail, and internet provider email accounts." },
      @{ Q = "Why are my emails not showing on my phone?"; A = "It is usually how the account is set up on the phone. We check the settings and get your email syncing the same way on every device." },
      @{ Q = "Can you move my email to a new provider?"; A = "Yes. We set up the new account and help move your existing email, contacts, and calendars across." },
      @{ Q = "Do you help businesses with email?"; A = "Yes. Business email and Microsoft 365 are covered by our business IT support and Microsoft 365 support services." }
    )
    CtaTitle = "Get email support today."; CtaText = "Tell us what your email is doing and we will get it working properly."; CtaButton = "Get email help"
  },
  @{
    Slug = "antivirus"; Active = "individuals"; Intent = "personal"
    Title = "Antivirus Setup and Protection in Tasmania | TassieTech"
    Description = "Get the right antivirus for your devices, installed and set up properly by local technicians across Tasmania."
    Kicker = "Antivirus"; Heading = "Need Antivirus? Get the Right Protection in Tasmania"
    Intro = "The right antivirus protection, installed and set up properly to keep your devices secure."
    ProblemsKicker = "What we do"; ProblemsHeading = "Honest antivirus advice without commissions or upselling."
    ProblemsIntro = "There are dozens of antivirus products on the market, and not all of them are equal."
    Problems = @(
      @{ T = "Choose the right product"; D = "We know which products work best for different situations, whether you need basic protection or something more robust." },
      @{ T = "Install and configure"; D = "We install and set up antivirus to suit your system and how you use it, so it protects you without getting in the way." },
      @{ T = "Check it is working"; D = "Already have antivirus? We check it is running, up to date, and actually protecting you." },
      @{ T = "Remove what is already there"; D = "If something has already got in, our <a href=""{{root}}virus-and-malware/"">virus and malware removal</a> service cleans it up first." },
      @{ T = "Every device"; D = "Windows PCs, Macs, and laptops for the whole household." },
      @{ T = "Business protection"; D = "Enterprise-grade protection for teams is covered by our <a href=""{{root}}business-security/"">business security</a> service." }
    )
    StepsTitle = "How antivirus setup works."
    Steps = @("Let us know which device you want protected and what concerns you have.", "We install and configure antivirus software suited to your system and how you use it.", "Your device stays protected from threats so you can use it with confidence.")
    WhyHeading = "Experienced security experts."
    WhyText = "Cyber threats do not just target businesses: individuals are increasingly targeted too. We work across individual and enterprise-grade business security, and we make sure you understand what your antivirus does and what to look out for."
    Why = $IndividualWhy
    Quote = "We would not hesitate to use this service in the future!"; QuoteName = "Shirley"
    RelatedHeading = "More personal IT help."
    Faqs = @(
      @{ Q = "Do I need to pay for antivirus?"; A = "It depends on your device and how you use it. We give honest advice on what protection you actually need, without commissions or upselling." },
      @{ Q = "Can I have more than one antivirus installed?"; A = "It is best not to. Two antivirus products can conflict and slow your computer down. We help you choose one and set it up properly." },
      @{ Q = "Do Macs need antivirus?"; A = "Macs are targeted less often, but they can still pick up adware, scam pop-ups, and malware. We can advise on the right protection for your Mac." },
      @{ Q = "My antivirus says something is wrong. What should I do?"; A = "Do not ignore it. Call us and we can check whether it is a real threat and clean it up if needed." }
    )
    CtaTitle = "Protect your device today."; CtaText = "Tell us which devices you want protected and we will recommend the right setup."; CtaButton = "Protect my device"
  },
  @{
    Slug = "internet-or-router-problems"; Active = "individuals"; Intent = "personal"
    Title = "Internet and Router Help in Tasmania | TassieTech"
    Description = "Dropouts, slow speeds, or a new router to set up? Local techs fix home and business internet across Tasmania."
    Kicker = "Internet and routers"; Heading = "Internet or Router Problems? Get Help in Tasmania"
    Intro = "Fast internet troubleshooting and router setup for stable, reliable home and business connections."
    ProblemsKicker = "Internet problems we fix"; ProblemsHeading = "A stable connection, working properly before we leave."
    ProblemsIntro = "We understand the connectivity challenges Tasmanians face, including NBN variability across different areas."
    Problems = @(
      @{ T = "Wi-Fi dropouts"; D = "Wi-Fi that keeps dropping out, or rooms in the house where it never reaches." },
      @{ T = "Slow speeds"; D = "Internet that is slower than it should be. We check whether it is the router, the settings, or the connection." },
      @{ T = "Devices that will not connect"; D = "Printers, TVs, phones, or laptops that refuse to join the network." },
      @{ T = "New router setup"; D = "A new router or modem set up properly, with secure Wi-Fi and your devices reconnected." },
      @{ T = "NBN connection problems"; D = "Connection faults and dropouts. We find the cause and help you deal with your provider if it is on their end." },
      @{ T = "Business networks"; D = "For business Wi-Fi, switching, and firewalls, see <a href=""{{root}}unifi-network-support-tasmania/"">UniFi network support</a>." }
    )
    StepsTitle = "How internet support works."
    Steps = @("Explain your internet issues, including dropouts, slow speeds, or connection problems.", "We check your router, settings, and connection to find exactly what is causing the issue.", "We fix the issue and restore a stable connection so your internet runs smoothly again.")
    WhyHeading = "Experienced internet and network experts."
    WhyText = "Our techs have extensive experience with every kind of connectivity issue, across home and business network setups. Networking can be confusing, so we make it simple and check your setup works properly before we leave."
    Why = $IndividualWhy
    Quote = "Came out and went beyond to help fix our problem. Highly recommend."; QuoteName = "Deborah"
    RelatedHeading = "More personal IT help."
    Faqs = @(
      @{ Q = "Why does my Wi-Fi keep dropping out?"; A = "Common causes are router placement, interference, an ageing router, or a fault on the connection. We check each one and fix the cause." },
      @{ Q = "Is slow internet my router or my provider?"; A = "It can be either. We test your router, settings, and connection so you know where the problem is before you call your provider." },
      @{ Q = "Can you set up my new router?"; A = "Yes. We set it up securely, get your devices reconnected, and check everything works before we leave." },
      @{ Q = "Do you help with business networks?"; A = "Yes. Business Wi-Fi and networks are covered by our UniFi network support service." }
    )
    CtaTitle = "Get your internet working again."; CtaText = "Tell us what your connection is doing and we will find the cause."; CtaButton = "Fix my internet"
  },
  @{
    Slug = "best-managed-it-services-tasmania"; Active = "services"; Intent = "business-support"
    Title = "Best Managed IT Services Tasmania | TassieTech"
    Description = "Managed IT services for Tasmanian businesses: helpdesk, 24/7 monitoring, networks, and Microsoft 365 and Google management from a local Latrobe team."
    Kicker = "Managed IT services"; Heading = "The Best Managed IT Services in Tasmania"
    Intro = "Ongoing IT support for businesses that need reliable, proactive technology management."
    ProblemsKicker = "What is included"; ProblemsHeading = "Enterprise-level IT management for Tasmanian businesses."
    ProblemsIntro = "Tailored support, not a one-size-fits-all package from the mainland. Compare our <a href=""{{root}}care-packages/"">care packages</a>."
    Problems = @(
      @{ T = "Dedicated helpdesk"; D = "Fast support for your team from technicians who already know your setup." },
      @{ T = "Proactive monitoring"; D = "24/7 monitoring options so problems are caught early, before they slow your team down." },
      @{ T = "Network maintenance"; D = "Full network setup and maintenance, from business Wi-Fi to firewalls." },
      @{ T = "Microsoft and Google management"; D = "Accounts, email, file sharing, and security settings across <a href=""{{root}}microsoft-365-support-tasmania/"">Microsoft 365</a> and Google Workspace." },
      @{ T = "Cloud hosting"; D = "Hosting and cloud services planned around how your business actually works." },
      @{ T = "Phones and VoIP"; D = "Business phone and VoIP systems supported by the same team as the rest of your IT." }
    )
    StepsTitle = "How managed IT support works."
    Steps = @("We discuss your business, current systems, and the type of ongoing IT support you need.", "We monitor, maintain, and support your technology to keep everything running efficiently.", "You get fast support and stable systems that help your business run smoothly.")
    WhyHeading = "Your IT partner, not just a vendor."
    WhyText = "We take the time to understand your business goals and align your IT strategy with them. Think of us as your IT department, without the overhead of hiring in-house. When you need someone on-site, we can be there."
    Why = @("Local experts with enterprise knowledge.", "Based in Latrobe, supporting businesses across Tasmania.", "Plain-language recommendations focused on real outcomes.", "You always know what is happening with your IT and why.")
    Quote = "The support that Tassie Tech has given over the last 8 years has just been outstanding. As a small business their help has been tremendous and I highly recommend to anyone who is thinking of using them for their own ventures."; QuoteName = "Christine"
    RelatedHeading = "More business IT services."
    Faqs = @(
      @{ Q = "What is managed IT support?"; A = "Managed IT support means we look after your business technology on an ongoing basis. Instead of calling someone only when something breaks, we monitor, maintain, and support your systems so problems are caught early and your team stays productive." },
      @{ Q = "How is managed IT different from break-fix IT support?"; A = "With break-fix support you call a technician after something goes wrong and pay per job. Managed IT is proactive: we keep your systems maintained and monitored to prevent problems and reduce downtime." },
      @{ Q = "Is managed IT support worth it for a small business?"; A = "For most small businesses, yes. You get the benefits of an IT department without the cost of hiring in-house staff, along with more stable systems and someone who already knows your setup when you need help." },
      @{ Q = "How much does managed IT support cost?"; A = "It depends on the size of your team, your devices, and the systems you use. We talk through your needs first, then give you a tailored quote." },
      @{ Q = "Can you work with our existing systems?"; A = "Yes. We start by reviewing your current systems and how your business uses them, then recommend changes only where they will make a real difference." },
      @{ Q = "Do you offer on-site support for businesses?"; A = "Yes. When you need someone on-site, we can be there. We are based in Latrobe and support businesses across Tasmania." }
    )
    CtaTitle = "Get reliable IT support today."; CtaText = "Tell us about your team and systems and we will recommend the right level of support."; CtaButton = "Get business support"
  },
  @{
    Slug = "business-security"; Active = "services"; Intent = "business-support"
    Title = "Business Cyber Security in Tasmania | TassieTech"
    Description = "Protect your business from ransomware, viruses, and data breaches with commercial-grade security from local Tasmanian experts."
    Kicker = "Business security"; Heading = "Business Online Security Services in Tasmania"
    Intro = "Cyber security and protection services for local Tasmanian businesses."
    ProblemsKicker = "Commercial-grade protection"; ProblemsHeading = "Enterprise-calibre tools, tailored and priced for Tasmanian businesses."
    ProblemsIntro = "We protect workstations, laptops, mobiles, servers, and networks. See also <a href=""{{root}}cyber-security-tasmania/"">cyber security</a>."
    Problems = @(
      @{ T = "Antivirus and antimalware"; D = "Enterprise-grade endpoint protection deployed and managed across your devices." },
      @{ T = "Security policies"; D = "Cyber security policies written for how your business actually works." },
      @{ T = "Staff training"; D = "Security awareness training so your team can spot scams and phishing before they cause harm." },
      @{ T = "System hardening"; D = "Systems hardened against targeted intrusions, ransomware, and malicious insiders." },
      @{ T = "Ongoing monitoring"; D = "Proactive monitoring and regular hardening to reduce your attack surface before threats reach your door." },
      @{ T = "Backups and recovery"; D = "A <a href=""{{root}}backup-strategy-tasmania/"">backup strategy</a> that means you can recover if something does get through." }
    )
    StepsTitle = "How business security services work."
    Steps = @("We assess your business setup and identify potential security risks or weaknesses.", "We put security systems and safeguards in place, tailored to your business environment.", "You get ongoing protection to reduce risk and keep your systems secure.")
    WhyHeading = "ASD partner, Tasmanian based."
    WhyText = "TassieTech is an Australian Signals Directorate business partner, following ASD guidelines to manage secure networks and quickly combat threats. We make cyber security approachable, not intimidating, so you can make informed decisions about protecting your business and your customers' data."
    Why = @("Proactive, not reactive.", "Plain-language security advice.", "Based right here in Tasmania.", "Security support for individuals too, so our techs understand threats at every level.")
    Quote = "They consistently ensure that our IT systems run smoothly and efficiently, and their proactive approach to streamlining and improving our technology has made a significant difference."; QuoteName = "Adam"
    RelatedHeading = "More business IT services."
    Faqs = @(
      @{ Q = "Where should a small business start with cyber security?"; A = "Start with the basics that stop most attacks: MFA on every account, a password manager, managed antivirus, updates, and backups you have tested. We help you prioritise." },
      @{ Q = "Do you train staff?"; A = "Yes. Security awareness training helps your team recognise phishing, scams, and risky behaviour." },
      @{ Q = "What does being an ASD partner mean?"; A = "We are part of the Australian Signals Directorate cyber security partnership program and follow ASD guidance when securing networks and responding to threats." },
      @{ Q = "What should we do if we think we have been hacked?"; A = "Call us straight away on 03 6449 4214. Our emergency response page explains the first steps." }
    )
    CtaTitle = "Secure your business IT today."; CtaText = "Tell us about your setup and we will help you prioritise the biggest risks first."; CtaButton = "Secure my business"
  },
  @{
    Slug = "scale-your-business"; Active = "services"; Intent = "project"
    Title = "IT to Scale Your Business in Tasmania | TassieTech"
    Description = "Strategic IT planning that helps Tasmanian businesses streamline their systems and grow, with on-the-ground local consultants."
    Kicker = "Scale your business"; Heading = "IT Services to Scale Your Business in Tasmania"
    Intro = "Strategic IT support designed to help Tasmanian businesses streamline systems and scale efficiently."
    ProblemsKicker = "Strategic planning"; ProblemsHeading = "Technology that grows with your business."
    ProblemsIntro = "Tech moves fast, and keeping up is not easy. We are based in Tasmania and here for the long term, not fly-in consultants."
    Problems = @(
      @{ T = "IT planning and roadmaps"; D = "A phased technology roadmap that matches where your business is heading." },
      @{ T = "Workflow overhauls"; D = "We look at how work actually gets done and remove the manual steps that slow your team down." },
      @{ T = "Custom software"; D = "Custom applications built when off-the-shelf tools do not fit the way you work." },
      @{ T = "Automation and integration"; D = "Automate manual processes and connect the tools you already use, so your team can focus on the work that matters." },
      @{ T = "Emerging technology advice"; D = "Practical advice on new tools, without the hype, so you know what is worth adopting." },
      @{ T = "Scalable systems"; D = "Systems designed so growth does not create bottlenecks. See also <a href=""{{root}}microsoft-365-support-tasmania/"">Microsoft 365 support</a>." }
    )
    StepsTitle = "How business scaling IT works."
    Steps = @("We discuss your business goals, challenges, and current technology setup in detail.", "We design and put in place IT systems that support efficiency, growth, and scalability.", "Your technology supports expansion without slowing you down or creating bottlenecks.")
    WhyHeading = "Strategic planners with local knowledge."
    WhyText = "Every business is different. We take the time to understand your challenges and goals, then build solutions that actually fit. We skip the jargon and focus on outcomes, so you understand what we recommend, why it matters, and how it affects your bottom line."
    Why = @("Custom solutions for businesses across Tasmania.", "Real growth, with no middle-man.", "Clear communication and real results.", "Broad hands-on experience across business and personal IT.")
    Quote = "The team was professional, knowledgeable, and incredibly responsive throughout the entire process. They took the time to understand our business needs and delivered reliable IT solutions that made a real difference to our operations."; QuoteName = "Andrew"
    RelatedHeading = "More business IT services."
    Faqs = @(
      @{ Q = "When should a business plan its IT for growth?"; A = "Before the growth arrives. It is cheaper and less disruptive to plan systems, accounts, and processes ahead of new staff, sites, or services than to fix them afterwards." },
      @{ Q = "Do you build custom software?"; A = "Yes. When off-the-shelf tools do not fit, we can build custom applications and integrations around how your business works." },
      @{ Q = "Can you work with our existing systems?"; A = "Yes. We start with what you have and recommend changes only where they make a real difference." },
      @{ Q = "How do we start?"; A = "Send us a project enquiry with your goals and any deadlines. We will talk through your current setup and suggest a practical first step." }
    )
    CtaTitle = "We will help scale your IT systems."; CtaText = "Tell us where your business is heading and what is slowing it down."; CtaButton = "Plan a project"
  }
)

foreach ($supportPage in $SupportPages) {
  $links = if ($supportPage.Active -eq "individuals") { $IndividualHelpLinks } else { $BusinessHelpLinks }
  $supportContent = Build-SupportPageContent $supportPage $links
  $heroImage = if ($supportPage.Active -eq "individuals") { "assets/img/heroes/aurora-cradle.jpg" } else { "assets/img/heroes/office-services-1440.jpg" }
  $heroPosition = if ($supportPage.Active -eq "individuals") { "53% 51%" } else { "50% 0%" }
  Add-Page $supportPage.Slug $supportPage.Title $supportPage.Description $supportPage.Kicker $supportPage.Heading $supportPage.Intro $supportContent $supportPage.Active "compact" $heroImage $heroPosition
  Register-Faq $supportPage.Slug $supportPage.Faqs
  $schemaType = if ($supportPage.Active -eq "individuals") { "General IT support" } else { "Business IT support" }
  Register-ServiceSchema $supportPage.Slug $supportPage.Heading $supportPage.Description $schemaType "Tasmania"
}

# Care packages: Good, Better, Best. Y = included; any other value is shown as written.
$CarePackageRows = @(
  "#Support",
  "Guaranteed response times|Y|Y|Y",
  "Managed antivirus|Y|Y|Y",
  "Dedicated support agent's mobile|Y|Y|Y",
  "Unlimited remote support|Y|Y|Y",
  "Unlimited onsite support|TTS Care rates|Y|Y",
  "Unlimited after-hours support|TTS Care rates|TTS Care rates|Y",
  "#Security",
  "Password manager|Extra|Y|Y",
  "MFA security audit|Y|Y|Y",
  "Managed Microsoft 365 macro settings|Y|Y|Y",
  "User application hardening|Y|Y|Y",
  "Administrator access audit|Y|Y|Y",
  "Managed application patches|Y|Y|Y",
  "Managed Windows updates|Y|Y|Y",
  "Managed application control|Y|Y|Y",
  "Regular vulnerability scanning|Extra|Extra|Y",
  "SSO setup and management|N/A|N/A|Y",
  "#Management",
  "IT documentation|Y|Y|Y",
  "Procurement assistance|Y|Y|Y",
  "Monthly executive report|Extra|Y|Y",
  "Cyber emergency response plan|Extra|Y|Y",
  "Hardware upgrade plan|Extra|Y|Y",
  "Real-time system monitoring|Extra|Extra|Y",
  "Technology business review|Bi-annual|Quarterly|Monthly",
  "Asset management report|Extra|Annually|Bi-annually",
  "#Training",
  "Security awareness training|Y|Y|Y",
  "End user training|TTS Care rates|Y|Y",
  "#Services",
  "Microsoft 365 licence|Standard|Standard|Premium",
  "Microsoft 365 backup|Y|Y|Y",
  "Local workstation backup|Extra|Y|Y",
  "Backup restoration test|Bi-annually|Quarterly|Monthly",
  "Dropbox Business licence|Extra|Extra|Business Plus"
)

$carePackageBody = ($CarePackageRows | ForEach-Object {
  if ($_.StartsWith("#")) {
    "        <tr class=""compare-group""><th colspan=""4"" scope=""colgroup"">$($_.Substring(1))</th></tr>"
  } else {
    $cells = $_ -split "\|"
    $values = ($cells[1..3] | ForEach-Object {
      if ($_ -eq "Y") { "<td><span class=""compare-yes"" role=""img"" aria-label=""Included"">&#10003;</span></td>" } else { "<td>$(Encode-Html $_)</td>" }
    }) -join ""
    "        <tr><th scope=""row"">$(Encode-Html $cells[0])</th>$values</tr>"
  }
}) -join "`n"

$carePackagesContent = @"
<section class="section">
  <div class="grid two">
    <div class="rich-text reveal">
      <span class="section-kicker">Managed service plans</span>
      <h2>Support for every part of your business.</h2>
      <p>Our care packages bundle support, security, management, training, and backup into three levels: Good, Better, and Best. Every plan includes guaranteed response times, managed antivirus, unlimited remote support, and a dedicated support agent you can call directly.</p>
      <p>Not sure which level fits? We will review your team, devices, and risks first, then recommend the plan that makes sense.</p>
    </div>
    <div class="card reveal">
      <h3>Reading the table</h3>
      <ul><li>&#10003; means the item is included in the plan.</li><li>TTS Care rates means the work is available and charged at our care rates.</li><li>Extra means it can be added to the plan.</li><li>Response times are set out in our <a href="{{root}}guaranteed-response-times/">response time guide</a>.</li></ul>
    </div>
  </div>
</section>
<section class="section tight">
  <div class="section-header center reveal">
    <span class="section-kicker">Compare plans</span>
    <h2>Good, Better, and Best.</h2>
  </div>
  <div class="compare-table-wrap reveal">
    <table class="compare-table">
      <caption class="sr-only">TassieTech care packages compared</caption>
      <thead>
        <tr><th scope="col">Plan</th><th scope="col">Good</th><th scope="col">Better</th><th scope="col">Best</th></tr>
      </thead>
      <tbody>
$carePackageBody
      </tbody>
    </table>
  </div>
  <p class="compare-note reveal">Managed service agreements are covered by our <a href="{{root}}general-terms-and-conditions/">general terms</a>, <a href="{{root}}minimum-hardware-requirements/">minimum hardware requirements</a>, and <a href="{{root}}recommended-technology-platform/">recommended technology platform</a>.</p>
</section>
$(SingleCtaPanel "Find the right care package." "Tell us about your team and we will recommend the plan that fits." "business-support" "Ask about care packages")
"@
Add-Page "care-packages" "IT Care Packages for Businesses | TassieTech" "Compare TassieTech's Good, Better, and Best IT care packages: support, security, backups, Microsoft 365, and monitoring for Tasmanian businesses." "Care packages" "TassieTech Care Packages" "Support, security, management, training, and backup for every part of your business." $carePackagesContent "services" "compact" "assets/img/heroes/office-services-1440.jpg" "50% 0%"
Register-ServiceSchema "care-packages" "TassieTech Care Packages" "Good, Better, and Best managed IT care packages for Tasmanian businesses." "Managed IT support" "Tasmania"

$devonportBusinessContent = @"
<section class="section">
  <div class="grid two">
    <div class="rich-text reveal">
      <span class="section-kicker">Devonport businesses</span>
      <h2>IT support from right next door in Latrobe.</h2>
      <p>We understand the needs of Devonport's business community. Our aim is to help your business thrive with IT that simplifies your operations, improves security, and boosts productivity.</p>
      <p>Join the many Devonport businesses that trust TassieTech for their IT support and development. For our full Devonport service area, see <a href="{{root}}it-services-for-devonport/">IT services for Devonport</a>.</p>
    </div>
    <div class="card reveal">
      <h3>Why Devonport businesses choose us</h3>
      <ul><li>Based in Latrobe, minutes from Devonport.</li><li>Onsite visits where they make sense.</li><li>Involved with the Devonport Chamber of Commerce and Industry.</li><li>Plain-language advice from a local team.</li></ul>
    </div>
  </div>
</section>
<section class="section">
  <div class="section-header center reveal">
    <span class="section-kicker">Our services in Devonport</span>
    <h2>Everything your business runs on, supported locally.</h2>
    <p>From support for a broad range of business software and hardware to bespoke software built for your needs.</p>
  </div>
  <div class="grid three service-link-grid">
    <a class="card lift reveal" href="{{root}}business-it-support-tasmania/"><h3>Complete business IT support</h3><p>Seamless operations with expert help for devices, accounts, and everyday issues.</p></a>
    <a class="card lift reveal" href="{{root}}cyber-security-tasmania/"><h3>Simplified IT consultations</h3><p>Digital security and tools explained in plain language for your business.</p></a>
    <a class="card lift reveal" href="{{root}}scale-your-business/"><h3>Custom software development</h3><p>Tailor-made tools for efficient workflows.</p></a>
    <a class="card lift reveal" href="{{root}}wordpress-care-tasmania/"><h3>Website development and hosting</h3><p>Websites built, hosted, and looked after locally.</p></a>
    <a class="card lift reveal" href="{{root}}scale-your-business/"><h3>Emerging technologies advisory</h3><p>Practical, future-ready advice on what is worth adopting.</p></a>
    <a class="card lift reveal" href="{{root}}unifi-network-support-tasmania/"><h3>Phone and internet network support</h3><p>Reliable connectivity for your office and team.</p></a>
  </div>
</section>
$(GoogleMapSection "Visit TassieTech in Latrobe, next door to Devonport." "Our Latrobe base is minutes from Devonport, so onsite help is close when you need it.")
$(SingleCtaPanel "We work with Devonport businesses." "Tell us what your business needs and we will help you choose the next practical step." "business-support" "Get business support")
"@
Add-Page "expert-it-services-for-devonport-businesses" "Expert IT Services for Devonport Businesses | TassieTech" "IT support and development for Devonport businesses from a local team based right next door in Latrobe." "Devonport" "Expert IT Services for Devonport Businesses" "Devonport's local IT support and development experts, based right next door in Latrobe." $devonportBusinessContent "areas" "compact" "assets/img/heroes/devonport.jpg" "48% 49%"
Register-ServiceSchema "expert-it-services-for-devonport-businesses" "Expert IT Services for Devonport Businesses" "IT support and development for Devonport businesses from a local team based in Latrobe." "Business IT support" "Devonport"

$areaFaqs = @(
  @{ Q = "Do you provide onsite support everywhere in Tasmania?"; A = "We are North West based. Onsite support is strongest around our local region, while many business support tasks can be handled remotely across Tasmania and onsite work can be planned where it makes sense." },
  @{ Q = "Can Hobart, Launceston, and East Coast businesses still work with TassieTech?"; A = "Yes. We support businesses through remote tools, Microsoft 365 administration, cloud systems, security work, website support, and planned project delivery across Tasmania." },
  @{ Q = "Which towns do your service area pages cover?"; A = "The site includes public service-area pages for Burnie, Devonport, Launceston, Hobart, Wynyard, Smithton, Penguin, Queenstown, Zeehan, George Town, Perth, Campbell Town, St Helens, New Norfolk, Sorell, Kingston, Huonville, and other Tasmanian locations." }
)
$areasContent = @"
<section class="section media-split">
  <div class="area-map reveal" aria-label="Map of Tasmania showing TassieTech service areas">
    <svg class="tasmania-svg" viewBox="0 0 420 430" role="img" aria-labelledby="tas-title tas-desc">
      <title id="tas-title">Tasmania service map</title>
      <desc id="tas-desc">A recognisable Tasmania map showing town service nodes connected to their nearest city hub. The city backbone runs Burnie to Devonport to Launceston to Hobart.</desc>
      <defs>
        <linearGradient id="tas-gradient" x1="86" y1="42" x2="334" y2="372" gradientUnits="userSpaceOnUse">
          <stop offset="0" style="stop-color: var(--brand-strong)"/>
          <stop offset="0.56" style="stop-color: var(--brand)"/>
          <stop offset="1" style="stop-color: var(--accent)"/>
        </linearGradient>
      </defs>
      <path class="tas-shore" d="M353 256.7L353.2 257.8L354.1 258.5L354.3 259.5L353.7 260.5L352.7 260.9L352.9 262L352.4 263L351.4 263.5L351.6 264.6L352.6 264.3L353.6 264.9L354.7 265.1L355 266.1L354.7 267.2L354.2 268.2L354 269.3L353.1 270L352.9 271.1L352.5 272.1L351.9 273L351.5 274.1L350.8 273.2L350.6 272.1L349.5 271.9L348.5 271.3L348.2 270.3L348.7 269.3L349.5 268.5L349.9 267.5L350.7 266.7L350.6 265.6L350 264.6L349 264.2L349 263.1L349.8 262.2L350.8 261.8L351.5 260.8L350.4 260.5L349.8 259.5L348.8 259.2L347.7 259L347.2 258L346 257.8L344.9 257.6L343.8 257.4L342.7 257.3L341.6 257.3L340.4 257.3L339.3 257.5L338.2 257.7L337.3 258.2L336.5 259L336.6 260.1L336.7 261.2L336.6 262.4L336.8 263.5L336.4 264.5L336.1 265.6L335.4 266.5L334.5 267.1L334 268.1L333.5 269.1L332.7 269.9L332.3 271L333.2 271.7L332.7 272.7L332.4 273.8L332.2 274.9L331.6 275.8L331.8 277L332.6 277.7L332.8 278.8L333 279.9L332.5 280.9L332.1 281.9L331.3 282.7L330.7 283.7L330.4 284.8L330.8 285.8L331.2 286.9L331.4 288L332.2 288.7L332.2 289.8L331.5 290.7L331.2 291.9L331.2 293L331.8 294L331.3 294.9L330.2 294.7L329.5 295.6L328.8 296.5L328.6 297.5L327.5 297.4L326.7 296.7L326.7 295.6L325.9 294.8L326.4 293.8L325.5 294.4L324.9 295.3L325.7 296L325.9 297.1L324.9 297.5L323.8 297.8L323.6 298.9L324.6 299.4L325.5 299.9L326 300.9L326.8 301.7L327.5 302.5L327.6 303.6L327.2 304.6L327.8 305.6L328.7 306.2L328.5 307.3L329.1 308.2L328.8 309.3L328 310L327.5 311L327.7 312.1L328 313.2L327.3 314.1L326.2 314.4L325.2 314.8L324.4 315.6L323.8 316.5L323.4 317.6L323.1 318.7L322.9 319.9L322.9 321L323.1 322.1L323.4 323.1L322.8 322.2L322 322.9L322 324L321 324.4L320.8 325.5L320.1 326.4L319.4 327.2L320.2 327.9L321.3 327.7L322.4 327.7L323.6 327.8L324.6 328L325.2 329L325.3 327.9L325 326.8L323.9 326.5L322.8 326.4L323.2 325.3L323.7 324.3L324.4 323.5L325.5 323.7L326.4 324.3L326.5 325.4L327.2 326.3L328.3 326.1L329.2 325.5L328.8 326.6L329.8 327.1L330.5 327.9L330.9 329L331.4 330L331.2 331.1L330.6 332L330.8 333.1L331.4 334L330.7 334.7L330.1 335.7L329 335.9L328.6 337L327.8 337.7L326.9 338.4L326.7 339.5L327.3 340.4L328.4 340.7L328.5 341.8L328.6 343L328.8 344L329.1 345.1L329.5 346.1L330.3 346.9L330.2 348L329.2 348.4L328.5 349.3L329.6 349.4L330.7 349.5L331.8 349.5L331.3 350.5L330.4 351.2L330.1 352.3L329.5 353.2L329.2 354.3L329.7 355.2L330.7 355.8L331.5 356.6L330.5 357.1L329.6 356.4L328.5 356.3L328.2 355.3L327.4 354.5L326.3 354.3L325.3 353.9L324.6 353L324.5 351.9L324.5 350.8L324.3 349.7L324.1 348.6L323.1 348.9L322.6 347.9L322.4 349L322.2 350.1L321.4 350.9L322.1 351.7L322.9 350.9L322.9 352L322 352.7L322.8 353.5L323.5 354.4L323.3 355.5L322.3 355.1L321.6 354.2L320.5 354.6L319.7 355.2L318.7 355.8L318.1 356.8L318.3 357.9L317.2 358L317.2 356.9L316.6 356L315.5 355.5L314.7 354.8L313.6 354.8L312.6 354.5L312.8 353.3L311.8 352.8L311.6 351.7L311.7 350.6L311.1 349.7L311.6 348.7L312.5 348.1L313.5 348.4L314.1 347.5L313.4 346.7L314.4 347L314.5 345.9L313.4 345.7L312.4 346.3L311.3 346.1L310.3 345.9L309.5 345.2L308.5 344.7L307.7 343.9L306.7 343.3L306.7 342.2L306.9 341.1L306.7 340L306.6 338.9L306.5 337.8L307.3 337L308.4 336.8L309.4 337.2L310.4 336.7L310.8 335.6L310.3 334.6L310.1 333.5L309.5 332.6L310.1 331.7L311.2 332.1L311.8 333L312.9 333.1L313.6 334L313.6 335.1L313.3 336.1L312.7 337.1L312.4 338.1L313.2 338.9L314.3 338.7L314.8 339.7L314.9 340.9L315.9 340.5L316.4 341.5L317.5 341.6L318.6 341.6L319.2 342.6L320.3 342.5L321.4 342.1L320.8 341.2L321.1 340.1L321.9 340.9L322.3 342L322.6 340.9L323 339.8L324 339.4L325.1 339.2L326.2 338.9L325.1 338.9L324 338.9L323 338.3L321.9 338.5L321.2 337.7L320.9 336.6L321.9 336.1L320.9 335.6L319.9 335.2L319.2 334.3L320.3 334.3L321.2 333.6L321.8 332.7L320.7 332.6L320.1 331.6L319.2 331L319.9 330.1L319.7 329L318.8 328.3L317.8 327.9L317 328.6L315.9 328.8L314.9 328.2L313.8 328.3L313.3 327.4L312.3 327.8L311.2 327.8L310.5 328.7L309.7 327.8L308.7 327.4L307.8 326.8L307.1 325.9L306 325.8L305.7 324.7L305.5 323.6L304.5 323.1L303.4 323L302.3 323.2L301.3 323.5L300.3 324L299.4 324.7L298.8 325.6L299.2 326.6L298.7 327.6L298.3 328.7L298.3 329.8L299.4 330L300.2 330.8L300.7 331.8L301 332.8L301.1 333.9L300.2 333.4L299.3 334.1L299.8 335.1L300.2 336.1L301.1 335.4L300.5 334.4L301.6 334.2L301.8 335.3L301.2 336.2L300.2 336.6L300.5 337.7L299.9 338.7L298.9 339.2L297.9 339.5L297 340.2L295.9 340.3L294.8 340.6L293.8 341L292.8 341.4L292.3 340.4L293 339.5L292.7 338.4L291.8 337.8L291.9 336.7L292 335.6L292.3 334.6L292.4 335.7L293.2 336.4L293.2 337.5L293.8 338.4L293.9 339.5L294.8 340.1L296 340.1L296.8 339.3L296.7 338.2L296.6 337.1L297.2 336.2L296.8 335.1L295.7 334.9L295.4 333.9L295.7 332.8L295.7 331.7L296.2 330.7L297.3 330.5L298 329.6L297 329.1L295.9 329.5L294.8 329.2L294.2 330.2L293.8 331.2L293 332L292.7 330.9L292.9 329.9L292.9 328.7L292.4 327.8L291.7 326.9L290.6 326.7L289.8 325.9L288.8 325.5L289 324.4L288.1 323.9L287.4 323L286.8 322.1L286.4 321.1L285.4 320.6L284.4 320.1L284.8 319L284.4 318L283.3 318L282.9 317L282.4 316L281.9 315L280.8 314.7L279.8 314.2L279.1 313.3L278 313.5L277.3 314.3L276.5 315.1L275.4 315.5L274.9 316.5L274 317.1L273 317.6L272 318.1L271 317.7L269.9 317.4L271 317.8L271.9 318.3L272.9 317.8L273.9 317.2L274.9 316.9L275.4 315.9L276.5 315.5L277.4 314.9L278.5 314.5L279.5 314.7L280.5 315.3L281.2 316.1L282.2 316.7L282.6 317.7L283.1 318.7L284.2 318.8L283.2 319.2L282.6 320.1L282.8 321.2L283.7 321.9L284.7 321.5L285.7 321.6L286.8 322.5L286.5 323.6L286.8 324.7L287.7 325.3L287.9 326.4L287.9 327.5L287.5 328.6L288.4 329.3L289.4 329.8L289.5 330.9L289.1 331.9L289.1 333L288.2 333.7L287.9 334.8L287.1 335.6L287.3 336.7L287 337.7L287.3 338.8L287.7 339.8L287.8 340.9L288.2 341.9L287.2 342.5L286.1 342.4L285.6 341.4L285.2 340.4L284.8 339.4L284.4 338.3L283.5 338.9L283.8 340L283.6 341.1L283.3 342.1L283 343.2L283.8 344L284.8 344.4L285.4 345.4L284.7 346.2L283.7 346.5L283.5 347.6L282.5 348.1L282.2 349.2L281.7 350.2L281.4 351.3L281.5 352.4L281.6 353.5L282.2 354.4L282.6 355.4L282.7 356.5L282.6 357.6L282.1 358.6L281.6 359.6L281.4 360.7L280.9 361.7L279.9 362.1L278.8 361.8L277.7 361.8L276.7 362.3L275.2 363.3L273.7 363.2L272.1 363L271 363L270.7 364.1L270.2 365.1L270.3 366.1L269.3 365.8L268.6 364.9L267.5 365L266.4 365.1L265.8 366L266.7 366.8L267.6 367.5L268.6 367.9L269.5 368.6L269 369.6L268.7 370.7L267.8 371.3L267.4 372.4L266.8 373.4L266.4 374.4L267.2 375.2L266.8 376.3L265.9 375.6L264.9 376.1L263.9 375.4L263 376.1L261.9 376L261.4 375.1L260.7 374.2L260.7 375.3L260.3 376.4L261.4 376.2L262 377.1L263.1 376.9L264.1 377.4L265 378L265.5 378.9L264.9 379.9L264 380.6L263.4 381.5L262.6 382.3L262.6 383.4L261.9 384.3L260.8 384.5L260.1 385.4L259.6 384.4L259.5 383.3L258.7 384.1L258.4 385.2L258.5 386.3L258.2 387.4L258.3 388.5L259.3 388.2L260.3 387.6L260.5 388.7L260.1 389.7L259.7 390.7L258.8 391.4L257.9 392.1L257.2 392.9L256.1 393.2L255 393.3L254.1 394L254.8 393.1L254.6 392L253.9 391.2L252.9 390.7L251.8 390.4L250.8 390.8L250 391.5L248.9 391.1L248 391.8L247.4 392.7L246.3 392.8L245.6 392L245.3 390.9L244.9 389.9L243.8 389.8L243.3 390.8L242.8 389.8L242.9 388.7L241.8 389.1L241.6 388L241 387.1L239.9 387.4L239.1 386.7L239.2 385.6L238.4 384.9L237.3 384.3L236.3 383.9L235.3 383.5L234.4 384.1L233.4 383.5L232.4 384L231.9 385L230.9 384.6L230 385.2L229 384.6L227.9 384.6L226.8 384.5L225.7 384.5L224.7 384.2L223.9 383.4L223 382.9L221.8 382.9L220.9 383.5L220.5 384.5L219.5 385L218.5 384.8L217.8 383.9L217.3 382.9L217.7 381.8L217.1 380.9L216 380.5L214.9 380.6L213.8 380.9L213.5 381.9L213.5 383L213.5 384.1L212.7 384.9L211.9 384.1L211.5 383.1L210.5 382.8L210.1 381.7L209.1 382.4L209.4 383.4L208.4 383.1L207.5 383.7L206.8 384.6L207 385.7L206 386.2L205.6 385.2L204.5 385.5L203.8 386.3L202.7 386L202.2 387L202 385.9L201.9 384.8L202.1 383.8L202.3 382.7L202 381.6L201.6 380.6L201.5 379.5L201.6 378.4L200.6 377.8L200.5 376.8L199.7 375.9L199.7 374.8L199.3 373.8L198.5 373L198 372L197.3 371.1L196.2 371L195.4 371.7L194.4 371.1L191.5 367.8L189 365L189.7 364.2L189.6 363.1L188.6 362.7L187.6 362L187.4 361L187.6 359.9L186.9 359L187.1 357.9L186.4 357.1L186.7 355.9L186 355L185.6 354L184.5 353.9L183.7 353.1L183.6 352L182.9 351.2L182.5 350.2L181.6 349.6L181.5 348.5L181.9 347.4L180.8 347.2L179.9 347.9L179.1 347.1L178.5 346.2L177.5 345.7L177.8 344.6L178.1 343.6L178.9 342.8L178.3 341.8L177.3 341.4L176.2 341.4L175.9 340.3L175.4 339.3L174.6 338.6L173.9 337.8L173.7 336.7L173 335.8L172.2 335L171.1 334.8L170.1 335.3L169.1 335.7L168 335.7L167 336.1L166.4 335.2L166.4 334.1L166.3 332.9L166.2 331.9L165.6 330.9L165.4 329.8L164.5 329.1L163.6 328.5L163.3 327.5L162.7 326.5L162.5 325.4L162.3 324.3L161.7 323.4L161.5 322.3L161.3 321.2L161.2 320.1L160.9 319.1L160.5 318L159.5 317.5L158.9 316.6L158.7 315.5L159.4 314.7L159.5 313.6L158.8 312.8L158.5 311.7L158.3 310.6L157.8 309.6L157.8 308.5L157.8 307.4L156.9 306.7L155.8 306.8L155.5 305.7L155.4 304.6L154.4 304.2L153.4 303.9L152.6 304.7L151.5 304.7L151 303.7L152 303.4L152.9 302.7L153.1 301.6L153.6 300.6L153.4 299.5L152.5 298.9L152.1 297.9L151.5 297L151.3 295.9L150.3 295.3L150.8 294.3L150.6 293.1L150.3 292.1L149.5 291.4L149.7 290.3L150 289.2L150.1 288.1L149.8 287.1L149.3 286.1L149.3 285L149.1 283.9L148.4 283L148.7 281.9L148 281.1L147.8 280L147.3 279L146.6 278.1L146.6 277L147.2 276.2L147.6 275.1L147.7 274L147.4 272.9L147.2 271.9L146.5 271L146.2 269.9L146 268.8L146.1 267.7L145 267.3L145.6 266.3L146.7 266.7L147.4 267.5L147.8 268.6L148.4 269.5L148.2 270.5L149.1 271.2L149.2 272.3L150.3 272.7L150.4 273.8L150.8 274.8L151.7 274.2L152.8 274.3L153.1 275.4L154.1 275L154.1 276.1L154.1 277.2L154.7 278.1L155.5 278.8L156.5 279.4L157.4 280L158.2 280.8L159 281.5L159.8 282.3L160.9 282L161.6 282.8L162.4 283.6L162.8 284.6L163.4 285.6L163.2 286.7L163.1 287.8L163.6 288.8L163.8 289.8L164.1 290.9L164.3 292L164.2 293.1L164.3 294.2L164.7 295.2L165.1 294.2L164.8 293.1L165.1 292L164.9 290.9L164.8 289.8L164.6 288.7L163.7 288.1L164.5 287.3L165.5 286.8L166.5 287.2L167.4 287.8L168.2 288.6L169.3 288.3L170.4 288.1L171.4 288.6L172.4 289L173.6 289L174.2 288.1L175.2 288.3L176.2 287.6L177.2 288L176.2 287.5L175.2 288.1L174.3 287.6L174.1 288.7L173 288.7L171.9 288.7L171 288L169.9 287.8L169 288.4L168 288L168.1 286.9L168.4 285.8L168.9 284.8L168.9 283.7L169.5 282.8L169.5 281.7L170.4 281L169.6 280.3L168.9 281.1L168.4 282.1L167.3 282L168.2 281.4L168 280.3L167.5 279.3L166.7 278.5L166.1 279.5L165.7 280.5L164.9 279.8L164.4 278.9L164.2 277.8L163.2 277.3L162.2 276.9L161.9 275.9L161.5 274.8L160.6 274.2L159.8 273.3L159.2 272.4L158.5 271.4L157.8 270.6L157.9 269.4L158 268.4L158.1 267.2L157 267.7L156.9 266.6L157.4 265.6L156.9 264.5L155.7 264.1L155.6 263L154.5 262.8L154.4 263.9L153.9 264.9L152.9 265.3L152 266L151.4 267L152.2 267.8L152.4 266.7L152.6 267.8L152.7 268.9L151.9 269.7L150.8 269.5L150 268.7L148.8 268.8L148.7 267.7L149.5 266.9L150.1 265.9L150.6 264.9L150.8 263.8L150.9 262.7L151 261.5L151 260.4L151 259.3L150.9 258.2L150.7 257.1L150.5 256L150.3 254.9L150 253.8L149.6 252.7L149.2 251.7L148.9 250.6L148.4 249.6L148 248.5L147.6 247.5L147.1 246.5L146.7 245.4L146.2 244.5L145.5 243.6L144.7 242.8L143.8 242.2L143 241.4L142.1 240.8L141.6 239.8L140.9 238.9L140.2 238.1L139.3 237.5L138.6 236.6L138.2 235.6L137.7 234.6L137.2 233.6L136.3 232.9L135.6 232.1L134.9 231.2L134.3 230.3L134.2 229.2L133.4 228.4L133.1 227.3L132.5 226.4L131.8 225.5L131.1 224.6L130 224.4L128.9 224.7L128.3 223.8L128.1 222.7L127.8 221.6L128.6 220.9L128.2 219.8L127.6 219L127.4 217.9L127.2 216.8L127.1 215.7L126.7 214.6L126.4 213.6L126 212.5L125.5 211.6L125 210.6L124.5 209.6L124 208.6L123.5 207.6L122.9 206.6L122.4 205.7L121.7 204.8L121.2 203.8L120.7 202.9L120.1 201.9L119.7 200.9L119.1 200L118.1 199.4L117.4 198.6L117.4 197.5L118.5 197.4L119.1 196.5L119.2 195.4L119.1 194.3L118.8 193.2L118.4 192.1L117.8 191.2L117 190.4L116.4 189.5L116.3 188.4L115.4 187.7L115.1 186.7L114.8 185.6L114.5 184.5L114 183.6L113.2 182.8L113 181.7L112.9 180.6L113.3 179.5L113.2 178.4L113 177.3L112.5 176.3L112.1 175.3L112.4 174.3L111.9 173.3L111.7 172.2L112.2 171.2L112.3 170.1L112.2 168.9L111.9 167.9L111.4 166.9L111.1 165.8L110.2 165.2L109.3 164.5L109 163.5L108.3 162.6L108.9 161.6L109.4 160.6L109.2 159.5L109.5 158.4L109.2 157.4L108.7 156.3L108 155.5L109.1 155.1L109.7 154.2L110.7 153.7L110.6 152.6L111.7 152.9L112.8 153L113.4 152L113.9 151L114.2 149.9L114.5 148.8L114.7 147.7L114.6 146.6L113.9 145.8L113.9 144.7L113.9 143.5L114.1 142.5L114.3 141.4L114.5 140.3L114.1 139.2L113 139.1L112.9 137.9L112.7 136.8L112.5 135.8L113.1 134.8L113.7 133.8L113 132.9L113.2 131.8L114 131.1L115 130.5L115.5 129.6L115.7 130.7L116.2 131.7L116.7 132.7L117 133.8L117.7 134.7L118.6 135.3L118.2 136.4L118.4 137.5L119.1 136.6L119.3 135.5L120.4 135.8L121 136.7L122 136.4L123 136.9L123.2 138L124.2 138.3L125.2 138.8L126.2 139.2L127.4 139.2L128.3 139.8L129.4 139.7L130.5 139.5L131.5 139.2L132.5 138.7L133.3 139.5L133.4 140.6L134.6 140.6L134.1 141.6L135 141L135 142.1L136.2 141.9L136.4 140.8L136.5 139.7L137.5 140.2L138.2 141.1L139 141.8L140 142.3L140.8 143.1L142 143.3L143 143.7L144.1 143.8L145.2 143.9L146.3 143.9L147.4 143.7L148.6 143.4L149.6 142.9L150.8 142.4L151 141.4L151.3 140.3L151.4 139.2L150.8 138.2L150.2 137.3L150.3 136.2L151.4 136.6L151.7 137.7L152.8 137.9L153.3 138.9L153.5 140L152.6 140.7L152.1 141.7L152 142.9L152.7 143.8L153.1 144.8L153.7 145.7L154.3 146.7L155.1 147.4L156.1 148L157.2 148.1L158.3 148L159.4 148L160.3 148.5L161.3 149L162.2 149.6L163.3 149.9L164.4 149.8L165.5 149.5L166.4 148.8L167.3 148.2L167.4 149.3L168.1 150.2L168.1 151.3L169 152L169.8 152.7L170.4 153.6L171.5 153.6L172.6 154L173.5 154.6L174.5 155L175.6 155.3L176.6 155.8L177.7 155.8L178.8 155.8L179.9 156L180.9 156.4L182 156.7L181.6 157.7L181.7 158.8L182.2 159.8L183.2 160.4L184.1 160.9L185 161.6L185.5 162.6L186.3 163.3L187.3 163.9L188.3 164.4L189.4 164.6L190.5 164.7L191.6 164.7L192.6 165.2L193.6 165.5L193.9 166.5L194.9 167L196 166.9L197.1 166.8L198 167.4L199 167.8L200 168.4L200.8 169.1L201.8 169.7L202.7 170.2L203.9 170.2L204.4 171.1L205.5 171.4L206.5 171.8L207.6 172L208 173L209 173.5L210.1 173.6L210.7 174.6L209.7 175.2L208.6 175.1L207.6 174.9L206.5 175L205.4 175.2L206.5 175.1L207.5 174.9L208.5 175.5L209.6 175.6L210.5 175.1L210.8 174L211.7 174.6L212.8 174.5L213.9 174.7L214.9 175.2L216 175L217 174.7L218 175.2L219.1 175.3L220.2 175L221.3 174.9L222.2 175.5L223.3 175.6L223.5 176.7L223.6 177.8L223.3 178.8L222.7 179.7L223.8 179.8L224.2 180.8L225.2 181.3L224.7 180.3L224.2 179.3L223.9 178.3L223.8 177.1L224 176L225.1 176.1L226.2 176.2L227.2 175.8L228.4 175.3L229.5 175.3L230.6 175.1L231.6 174.6L232.5 174.1L233.5 173.5L234.3 172.7L234.6 171.7L235.5 172.3L235.4 173.4L235.4 174.5L236.1 175.3L236.5 176.4L237.1 177.2L236.8 178.3L237 179.4L237.5 180.4L236.9 181.4L237.4 182.3L237.6 181.3L238.1 180.3L238.7 181.2L239 182.2L238.8 183.3L239.2 182.3L239.3 181.2L239.3 180.1L238.5 179.3L237.7 178.5L237.8 177.4L238.1 176.3L238.9 175.6L239.7 174.9L238.6 175.1L237.5 175.3L236.9 174.4L238 174.2L239 173.8L240 173.3L240.9 172.6L241.5 171.7L242.3 170.9L242 169.8L243.1 169.6L244.1 170.1L245 169.5L245.9 168.8L246.6 167.9L246.2 166.9L247.2 167.4L248.1 168L249 168.6L250 167.9L250.9 166.7L251.7 166L252.5 166.7L253.5 166.2L254.1 165.2L255.1 164.7L256 164L256.9 163.5L258 163.1L258.9 163.8L260 163.8L261.1 163.6L262.1 163.3L263 162.6L263.8 161.9L264.6 161.1L265.2 160.1L266.2 159.8L267.3 159.8L268.4 160.2L269.5 160.1L270.1 161L271.2 160.9L272.3 161L273.4 161.2L274.4 161.7L275.3 162.3L276.3 161.8L277.4 161.8L278.3 161.1L279.4 160.9L280.3 160.3L281 159.4L281.6 158.4L282 157.5L282.9 156.8L283.9 156.2L284.6 157.1L285.7 157.4L286.7 157.1L287.6 156.4L288.7 156.5L288.9 157.6L289.2 158.6L290.2 159.2L291.2 159.7L291.4 160.8L292.2 161.6L293.2 161.7L294.4 161.4L295.4 161L296.4 160.4L297.3 159.8L298.2 159.1L299 158.3L299.7 157.5L300.4 156.6L301 155.6L301.7 154.7L302.3 153.7L302.8 152.7L303.5 151.8L303.9 150.8L304.4 149.8L304.8 148.8L305.2 147.8L306.3 147.7L307.3 147.2L308.2 146.5L309.1 145.9L310.2 146.3L311.1 147L311.4 148L312.2 148.8L313.3 149L314.4 148.7L315.5 148.6L316 149.6L316.8 150.4L317.9 150.8L318.9 151L320 151.2L321.2 151L322.2 150.6L323.1 149.9L324 149.3L324.7 148.4L325.4 147.6L326.1 146.6L326.7 145.7L327.2 144.7L327.7 143.7L328.1 142.7L327.9 141.6L328.7 140.8L328.9 139.7L327.8 139.4L327.5 138.3L328.5 138.7L329.6 138.5L330.7 138.5L331.8 138.7L332.7 139.3L333.7 139.8L334.4 140.6L335.5 141.1L336.6 141L337.5 141.7L338.2 142.5L338.6 143.5L339.2 144.5L339.9 145.3L340.7 146.1L341.7 146.6L342.9 146.4L343.2 145.4L343.8 146.3L344.7 147.1L345.7 147.6L346.1 148.7L346.2 149.7L346.9 150.7L347.9 151.2L348.8 151.8L349.2 152.9L349.5 153.9L350.1 154.9L350.9 155.7L351.4 156.7L351.6 157.8L352.4 158.6L352.7 159.6L353.5 160.4L354.6 160.5L353.6 161L352.8 161.8L352.2 162.7L351.6 163.7L351.1 164.7L350.9 165.8L350.7 164.7L349.7 164.2L348.8 164.9L349.5 165.8L350.5 166.3L350.9 167.3L350.6 168.4L350.3 169.5L349.8 170.5L349.5 171.6L349.3 172.7L349.4 173.8L349.8 174.8L350.3 175.8L349.7 176.8L349.4 178L349.6 179.1L350.2 180L350.3 181.1L350.7 182.1L351.3 183.1L352.4 183.2L353.5 183.3L353.6 184.4L353.3 185.5L352.4 186.2L352 187.2L351.3 188L351.1 186.9L350.4 186L349.7 186.9L349.6 188L349.7 189.1L348.8 189.6L347.7 189.9L348.6 190.5L349.5 191L350.3 190.2L351.3 189.7L352.1 188.9L352.3 187.8L353.1 187L353.4 186L354.5 185.6L354.2 186.7L353.5 187.5L353 188.5L352.7 189.6L352.5 190.7L352.2 191.8L351.7 192.7L351.2 193.7L350.8 194.8L350.7 196L350.3 197L349.9 198.1L349.8 199.1L349.5 200.2L349.2 201.3L349.1 202.4L349.1 203.5L349.2 204.7L349.7 205.7L350 206.7L350.1 207.9L350.4 209L350.6 210.1L351.5 210.7L352.3 211.5L352.5 212.6L352.6 213.7L352.6 214.8L352.7 215.9L352.3 216.9L351.7 217.8L351.1 218.7L350.7 219.8L350.6 220.9L350.8 222L350.5 223.1L350.3 224.3L350.5 225.4L351.1 226.4L351.3 227.4L350.3 227.9L349.9 229L349.5 230L349.1 231.1L349 232.3L349.1 233.4L349.2 234.6L349.5 235.7L350.1 236.7L350.8 237.5L351.8 237.9L351.6 239L351.9 240L352.6 240.9L352.9 242L352.4 242.9L351.5 243.7L351.5 244.8L352 245.8L351.1 246.4L350.7 247.5L350.5 248.6L350.3 249.7L350.3 250.8L350.3 252L350.5 253.1L351.1 254L352.1 254.5L352.4 255.6L352.9 256.5ZM315 62.1L315.7 61.6L316.4 61.1L316.5 60.3L317.3 59.9L318.2 59.6L318.5 58.8L319.3 58.5L320.2 58.4L321 58.6L321.5 57.9L321.6 57.1L321.1 56.3L321.7 55.7L322.4 55.2L322.8 54.5L322.6 53.7L322.6 52.8L321.9 52.2L321.5 51.5L322.3 51.1L323 51.5L323.7 52.1L324.5 51.7L325.1 51L325.8 50.7L326.5 50.2L327.1 49.6L327.5 48.8L328.4 48.7L329.2 49.1L328.7 49.8L328.7 50.6L328.9 51.5L329.2 52.3L329.4 53.1L329.5 52.3L330.2 52.7L330.7 53.4L330.4 52.6L329.8 51.9L329.5 51.1L329.1 50.4L329 49.6L329.5 50.3L329.9 51L330.4 51.8L330.9 52.5L331.5 53.1L332.1 53.7L332.6 54.4L333.1 55.2L333.5 56L334 56.7L334.6 57.4L335.1 58.1L335.7 58.7L336.3 59.4L336.9 60.1L337.4 60.7L338 61.5L338.5 62.3L339 63L339.5 63.7L340 64.4L340.5 65.1L341 65.8L341.6 66.4L342.3 67.1L342.9 67.7L343.6 68.2L344.3 68.6L345.1 68.2L345.8 68.7L346.5 69.2L347.3 69.6L348.1 69.9L348.9 70.2L349.8 70.2L350.6 70L350.5 70.8L350.3 71.7L350.1 72.5L350 73.4L350 74.2L350 75.1L350.2 76L350.3 76.8L350.4 77.7L350.4 78.6L350.5 79.4L350.5 80.3L350.6 81.2L350.8 82.1L350.9 82.9L351.2 83.7L351.4 84.6L351.6 85.4L351.8 86.2L352.1 87L352.2 87.9L352.4 88.7L352.8 89.5L353.1 90.3L353.5 91.1L353.1 91.9L352.5 92.4L351.7 92.9L350.9 93.2L350.1 93.4L349.5 92.8L349.2 92L348.5 91.5L347.6 91.8L346.8 91.5L346 91.6L345.1 91.9L344.5 92.5L344.2 93.3L343.9 94.1L343.9 94.9L343.1 95.3L342.4 95.8L341.8 96.4L341 96.4L340.1 96.6L339.6 97.2L338.9 96.7L338.1 96.3L337.4 96.8L337 96L336.2 95.7L335.6 95.1L334.8 95L334.4 94.2L334.2 93.3L333.4 93.2L333.1 92.4L333.9 92L334.3 91.2L334.2 90.4L333.8 89.6L333.3 88.9L332.8 88.2L332.6 87.3L332.7 86.5L332.7 85.6L332.6 84.7L332.5 83.9L332.3 83L332 82.2L331.2 81.8L330.6 81.2L329.9 80.7L329.5 80L328.6 80.2L329.2 80.8L328.7 81.5L328.5 80.6L328.5 79.8L328.4 78.9L328.1 78.1L327.8 77.3L327.5 76.4L326.8 76L326 75.7L325.2 76.1L324.4 76L323.8 75.4L323.1 74.9L322.3 75.1L322.7 74.4L323.5 74.2L324 73.5L324.7 73L325.2 72.3L325.2 71.4L325.4 70.6L325.3 69.7L325.1 68.9L324.9 68L324.6 67.2L324.2 66.4L323.8 65.6L323.2 65L322.6 64.3L321.8 64.1L321 64.4L320.2 64.7L319.5 65.1L318.8 65.7L318.4 64.9L317.8 64.3L317 63.9L316.3 63.5L315.5 63.3L315.3 62.4ZM56.7 65.6L56.9 64.8L57.1 64L57.5 63.2L57.5 62.4L57.8 61.6L58.1 60.8L58 59.9L58.7 59.4L58.9 58.5L58.7 57.7L58.4 56.9L58.5 56L58.5 55.2L58.5 54.3L58.2 53.5L57.8 52.7L57.8 51.9L58 51L58 50.2L57.7 49.4L57.4 48.6L57.5 47.7L58.4 47.6L59.1 47.1L59.8 46.6L60.6 46.3L61.2 45.7L61.8 45.1L62.3 44.4L62.7 43.6L63 42.8L63.2 42L63.3 41.1L63.1 40.3L63 39.4L62.8 38.6L62.8 37.7L63.4 37.2L63.7 36.4L64.6 36.2L65.2 36.8L66 37.1L66.5 37.8L67.3 38L68.2 38.2L68.8 38.8L69.5 39.3L70.3 39.7L71.1 40.1L71.5 40.9L72.1 41.5L72.7 42.1L73.3 42.7L74 43.3L74.7 43.8L74.9 44.7L74.8 45.6L74.7 46.4L74.6 47.3L74.5 48.2L74.4 49.1L74.3 50L74.3 50.9L74.3 51.8L74.4 52.6L74.5 53.5L74.7 54.4L75 55.2L75.3 56L75.7 56.8L76.1 57.5L75.9 58.4L75.6 59.2L75.4 60L74.9 60.7L74.6 61.6L74.5 62.4L74.6 63.3L74.7 64.2L74.8 65.1L75.4 65.7L76.2 66.2L76.7 66.8L76.7 67.7L76.5 68.5L76.4 69.4L76.4 70.3L76.4 71.1L76 71.9L75.9 72.7L75.4 73.4L75.3 74.3L74.8 75L74.3 75.6L74.4 76.5L74 77.3L73.1 77.4L72.3 77.6L71.8 78.3L71.8 79.2L70.9 79L70.7 79.9L70.1 80.5L69.4 81L68.6 81.3L68 81.8L67.1 81.7L66.4 82.1L66.3 83L65.4 82.9L64.6 82.8L63.9 83.4L63.4 84.1L62.7 84.5L62.5 85.4L63 86L62.8 86.9L62.3 86.2L61.7 85.6L61.1 85L61.6 84.3L61 83.7L60.1 83.8L59.5 83.2L59.5 82.4L59.3 81.5L59.1 80.7L59 79.9L58.7 79.1L59.4 78.6L60.2 78.2L60.3 77.4L60.1 76.5L60 75.6L60.2 74.8L60.6 74L60.2 73.3L60.3 72.4L60.1 71.6L59.9 70.7L59.3 70.1L59 69.3L58.4 68.7L57.8 68.1L57.2 67.5L57.4 66.7L56.7 66.2ZM274.9 380.8L274.5 380L274.5 379.2L274.6 378.3L274.3 377.5L273.7 376.9L273.2 376.2L272.5 375.7L271.9 375.1L271.7 374.3L272.2 373.6L273 373.7L273.7 374.2L274.1 375L274.5 375.7L274.9 376.5L275.5 377.1L276 377.8L276.8 378.1L277.5 377.6L277.2 376.8L277.1 375.9L277.8 375.4L278 374.5L277.2 374.7L277.2 373.8L276.7 373L277.1 372.3L277.7 371.7L277.7 370.8L277.6 370L277.5 369.1L277.8 368.3L278.2 369.1L278.7 369.8L278.7 370.6L279.4 371.1L280 370.5L280.1 369.6L281 369.5L280.8 368.7L280.5 367.8L280.5 367L281.2 366.5L281.5 365.7L281.6 364.8L282.1 364.1L282.8 363.7L283.5 363.1L283.5 362.3L283.7 361.4L284.4 360.9L284.6 360.1L284.7 359.2L285.2 360L285.4 360.8L285.3 361.6L285.6 362.4L285.7 363.3L286.6 363.3L287.4 362.6L287.9 362L288.4 361.2L288.9 360.5L289.2 359.6L289.1 358.8L289.1 357.8L288.5 357.2L288.9 356.5L289.5 355.8L290.1 356.3L290.8 355.8L291 354.9L291 354L290.7 353.2L289.9 352.9L289.3 353.6L288.4 353.7L287.6 353.6L287.9 352.8L287.2 352.3L286.6 352.9L285.8 353.2L285.4 352.4L284.5 352.4L283.8 352L284.3 351.3L285 350.8L284.4 350.2L285.1 349.7L285.9 349.3L286.5 349.9L287.1 350.5L287.6 349.8L288.2 349.2L288.9 349.7L289.3 348.9L289.3 348.1L288.6 348.7L288.2 347.9L287.5 348.5L287.4 347.7L286.5 347.8L285.8 347.3L286.5 346.8L286.8 346L287.1 345.2L287.8 344.7L288.4 344L288.8 343.2L289.6 343.4L289.7 344.2L289.6 345.1L290.4 345.4L290.5 346.3L291 347L291.3 347.8L291.9 348.4L291.9 349.3L291.5 350.1L291.4 351L291.5 351.8L292.4 352L292.6 352.9L292.7 353.7L292.7 354.6L293 355.4L293.8 355.8L294 356.6L294.2 357.5L294.1 358.3L293.9 359.2L293.2 358.7L292.3 358.6L291.5 359L290.7 359.4L289.9 359.9L289.3 360.5L288.7 361.1L288.1 361.8L287.5 362.7L287.1 363.4L286.8 364.2L286.8 365.1L286.9 365.9L287 366.8L286.8 367.6L287.1 368.4L287.4 369.2L288.1 369.7L288.9 369.4L289.4 368.8L290.3 368.7L290.7 369.5L290.7 370.3L290.5 371.2L290.1 371.9L289.4 372.4L288.7 372.9L288.5 373.8L288 374.5L288.3 375.2L287.9 376L287.3 376.6L287.1 377.5L286.9 378.3L286.7 379.2L287 380L287.1 380.8L286.9 381.7L286 381.8L285.5 382.5L284.8 382.1L284 381.8L283.5 381.1L283 380.4L282.2 380.7L281.8 379.9L281.8 379.1L281.5 378.2L282.4 378L282.3 377L281.8 376.3L281 376.2L280.2 375.8L279.2 375.9L278.7 376.5L279 377.4L278.4 378L277.7 378.5L277.6 379.4L277.6 380.2L276.8 380.4L276 379.9L275.5 380.6ZM349.2 102.7L349.7 102L350.1 101.2L351 101.3L351.8 100.9L352.5 100.4L353 99.7L353.4 98.9L353.9 99.6L354.5 100.2L354.9 101L355.5 101.6L355.7 102.4L356.1 103.2L356.9 103.6L357.5 104.3L357.9 105L358.5 105.6L359.3 105.9L360.1 106L360.9 106.4L361.1 107.2L361.1 108.1L361.2 108.9L361.8 109.5L362 110.4L362.6 111L363.4 111.4L362.8 112L362 111.8L361.2 111.5L360.4 111.9L360 112.7L360.2 113.5L359.4 113.8L358.6 114.1L358 114.7L358 115.6L357.2 116L356.9 115.2L356 115.2L355.3 115.7L354.8 116.3L354 116L353.8 115.1L353.8 114.3L353.5 113.5L353.2 112.7L352.7 111.9L352.4 111.2L351.6 110.8L351 111.3L350.3 110.8L349.6 111.2L349.2 111.9L348.5 112.5L348 113.2L347.2 113.6L346.5 114.1L345.8 113.6L345.5 112.8L345.2 112L344.5 111.6L343.7 111.9L343 112.4L342.2 112.6L341.5 113.1L340.8 113.6L341 112.8L340.5 112.1L339.7 111.8L339.1 112.5L338.3 112.6L337.4 112.9L336.7 113.2L335.8 112.9L335 112.6L334.4 112.1L334.4 111.2L333.6 111L333.5 110.2L332.8 109.6L332 109.8L331.3 110.4L330.7 109.8L330.8 109L330.9 108.1L330.7 107.3L331.2 106.7L332 106.4L332.6 105.8L333.5 105.5L333.9 104.8L334.7 104.4L335.5 104.7L336 104L336.7 103.5L337.5 103.5L338.3 103.2L339.2 103.2L339.9 102.8L340.8 102.7L341.4 103.3L342.3 103.4L343.1 103.7L343.9 103.7L344.7 104.1L345.2 103.3L345.4 102.5L345.5 101.7L346.3 101.4L346.6 102.2L347.4 101.9L348.1 102.4L348.9 102.7ZM342.3 306.5L341.8 306.8L341.3 307.3L341.2 307.9L340.6 307.7L339.9 307.8L339.4 308.1L339.1 307.6L338.4 307.5L337.8 307.5L337.1 307.5L336.5 307.9L336.2 308.5L336.1 309.1L336.4 309.7L337 309.7L337.3 310.3L337.4 310.9L337.8 311.4L337.7 312.1L337.7 312.7L337.1 313L336.4 312.8L335.9 312.5L336 313.1L335.4 313.1L334.8 312.9L334.2 313.3L333.8 313.8L333.3 314.2L332.7 314.5L332.4 313.9L332.5 313.3L332.5 312.6L333 312.2L333.4 311.7L333.6 311.1L333.9 310.5L334.1 309.9L334.5 309.4L335.1 309.6L335.7 309.4L335.9 308.8L335.9 308.2L335.6 307.6L335.1 307.1L334.5 307L334.1 307.5L333.6 307.9L333 307.9L332.4 307.5L333 307.3L333.6 307L334 306.5L334.1 305.8L333.8 305.2L333.3 304.9L333.5 304.2L334 303.8L334.3 303.2L334.7 302.7L334.8 302.1L334.9 301.5L335 300.8L335.6 300.5L335.9 299.9L336.3 299.4L336.8 299.8L337.1 300.4L337.6 300.8L338.3 300.6L338.9 300.6L339.5 300.9L339.7 301.5L340.1 302.1L340.4 302.6L340.4 303.3L340.6 303.9L340.9 304.5L341.1 305.1L341.5 305.6L342.1 305.9L342.6 306.3ZM124.9 136.7L125.3 136.2L125.5 135.6L125.3 134.9L125.2 134.3L125.1 133.6L125.1 133L125.5 132.4L126 132L126.5 131.6L127 131.1L127.4 130.6L127.8 130.1L128 129.5L128.1 128.8L128.3 128.2L128.9 128L129 128.6L129.3 129.2L129.2 129.8L129.6 130.3L130.2 130.5L130.9 130.7L131.4 131.1L131.3 130.4L131 129.8L130.7 129.2L130.5 128.6L131 129L131.3 129.6L131.7 130.2L132 130.8L132.3 131.3L132.8 131.8L133.3 132.2L133.9 132.6L134.4 133L135 133.3L135.6 133.4L136.3 133.3L136.9 133L136.5 133.6L136.8 134.2L137.1 134.8L137.5 135.4L137.9 135.8L137.4 136.2L136.7 136.3L136.2 135.9L135.7 135.5L135 135.2L134.4 135.4L133.9 135.9L133.3 135.7L132.7 135.4L132.1 135.4L131.5 135.7L131 136.1L130.5 136.6L130.1 137.2L129.5 137.5L128.9 137.3L128.3 137.3L127.7 137.6L127.4 138.2L126.8 138.2L126.1 138L125.6 137.6L125.3 137ZM342.1 123.9L341.8 123.3L341.3 122.9L340.7 123L340 123.1L339.4 122.9L339.2 122.2L339.4 121.6L339.4 121L339.4 120.3L338.8 120.2L338.1 120.3L337.9 119.7L338.3 119.2L338.6 118.6L339.2 118.3L339.8 118L340.1 117.5L340.7 117.2L341.4 117.1L342 117.1L342.7 117L343.3 116.7L343.8 116.3L344.4 116.3L344.8 116.8L345.2 117.3L345.8 117.2L346.2 116.7L346.5 116.1L346.9 115.7L347.5 115.4L347.9 115.9L347.8 116.5L347.4 117L347 117.5L346.9 118.2L346.8 118.8L346.7 119.5L347.1 120L346.7 120.5L346.4 121.1L345.9 121.5L345.4 121.9L345 122.4L344.6 123L344.3 123.5L344.3 124.2L344.7 124.6L344.1 124.8L343.5 125.1L342.9 124.8L342.6 124.2ZM114.6 118L114.9 117.4L115 116.8L114.6 116.2L114.6 115.6L115.2 115.5L115.7 115.9L116.4 116L117 116.2L117.5 115.8L117.8 115.2L118.1 114.6L118.6 114.1L118.5 113.4L118.1 112.9L118.2 112.2L118.5 111.6L118.7 111L118.9 110.4L119.4 109.9L119.3 109.3L119.5 108.6L119.8 109.2L119.9 109.8L119.8 110.5L119.7 111.1L119.8 111.8L119.7 112.4L119.8 113L119.8 113.7L119.5 114.3L119.8 114.9L119.9 115.5L119.7 116.1L119.7 116.8L119.6 117.5L119.6 118.1L119.4 118.7L119.1 119.3L118.6 119.8L118.6 120.4L118.6 121.1L118.5 121.7L118.5 122.4L118.7 123.1L118.8 123.7L118.8 124.4L118.5 125L118.3 125.6L117.9 126.1L117.2 126L116.8 125.6L116.2 125.3L116 124.6L115.9 124L115.5 123.5L115.6 122.8L115.8 122.2L116 121.6L115.7 121L115.6 120.3L115.5 119.7L115.3 119.1L115.2 118.4L114.7 118ZM122.8 112.2L123.1 111.6L123.1 111L123.7 111.3L124.4 111.2L125 110.9L125.4 110.4L125.8 109.9L126 109.3L125.6 108.7L126 108.2L125.7 107.7L126.2 107.3L126.8 107.3L127.3 107.8L127.9 108.1L128.5 107.8L129.2 107.8L129.8 108.1L130.3 107.7L130.9 108L131 108.6L130.8 109.2L131.1 109.8L131.5 110.3L131.3 110.9L130.8 111.4L130.2 111.6L130.1 112.3L130.1 112.9L130.5 113.5L129.8 113.5L129.5 114.1L129 114.5L128.4 114.8L127.9 115.2L127.3 115.5L126.7 115.7L126.2 115.3L125.6 114.9L125 114.5L124.4 114.4L124 113.9L123.9 113.2L123.5 112.6L122.9 112.4Z"/>
      <path class="tas-main" d="M353 256.7L353.2 257.8L354.1 258.5L354.3 259.5L353.7 260.5L352.7 260.9L352.9 262L352.4 263L351.4 263.5L351.6 264.6L352.6 264.3L353.6 264.9L354.7 265.1L355 266.1L354.7 267.2L354.2 268.2L354 269.3L353.1 270L352.9 271.1L352.5 272.1L351.9 273L351.5 274.1L350.8 273.2L350.6 272.1L349.5 271.9L348.5 271.3L348.2 270.3L348.7 269.3L349.5 268.5L349.9 267.5L350.7 266.7L350.6 265.6L350 264.6L349 264.2L349 263.1L349.8 262.2L350.8 261.8L351.5 260.8L350.4 260.5L349.8 259.5L348.8 259.2L347.7 259L347.2 258L346 257.8L344.9 257.6L343.8 257.4L342.7 257.3L341.6 257.3L340.4 257.3L339.3 257.5L338.2 257.7L337.3 258.2L336.5 259L336.6 260.1L336.7 261.2L336.6 262.4L336.8 263.5L336.4 264.5L336.1 265.6L335.4 266.5L334.5 267.1L334 268.1L333.5 269.1L332.7 269.9L332.3 271L333.2 271.7L332.7 272.7L332.4 273.8L332.2 274.9L331.6 275.8L331.8 277L332.6 277.7L332.8 278.8L333 279.9L332.5 280.9L332.1 281.9L331.3 282.7L330.7 283.7L330.4 284.8L330.8 285.8L331.2 286.9L331.4 288L332.2 288.7L332.2 289.8L331.5 290.7L331.2 291.9L331.2 293L331.8 294L331.3 294.9L330.2 294.7L329.5 295.6L328.8 296.5L328.6 297.5L327.5 297.4L326.7 296.7L326.7 295.6L325.9 294.8L326.4 293.8L325.5 294.4L324.9 295.3L325.7 296L325.9 297.1L324.9 297.5L323.8 297.8L323.6 298.9L324.6 299.4L325.5 299.9L326 300.9L326.8 301.7L327.5 302.5L327.6 303.6L327.2 304.6L327.8 305.6L328.7 306.2L328.5 307.3L329.1 308.2L328.8 309.3L328 310L327.5 311L327.7 312.1L328 313.2L327.3 314.1L326.2 314.4L325.2 314.8L324.4 315.6L323.8 316.5L323.4 317.6L323.1 318.7L322.9 319.9L322.9 321L323.1 322.1L323.4 323.1L322.8 322.2L322 322.9L322 324L321 324.4L320.8 325.5L320.1 326.4L319.4 327.2L320.2 327.9L321.3 327.7L322.4 327.7L323.6 327.8L324.6 328L325.2 329L325.3 327.9L325 326.8L323.9 326.5L322.8 326.4L323.2 325.3L323.7 324.3L324.4 323.5L325.5 323.7L326.4 324.3L326.5 325.4L327.2 326.3L328.3 326.1L329.2 325.5L328.8 326.6L329.8 327.1L330.5 327.9L330.9 329L331.4 330L331.2 331.1L330.6 332L330.8 333.1L331.4 334L330.7 334.7L330.1 335.7L329 335.9L328.6 337L327.8 337.7L326.9 338.4L326.7 339.5L327.3 340.4L328.4 340.7L328.5 341.8L328.6 343L328.8 344L329.1 345.1L329.5 346.1L330.3 346.9L330.2 348L329.2 348.4L328.5 349.3L329.6 349.4L330.7 349.5L331.8 349.5L331.3 350.5L330.4 351.2L330.1 352.3L329.5 353.2L329.2 354.3L329.7 355.2L330.7 355.8L331.5 356.6L330.5 357.1L329.6 356.4L328.5 356.3L328.2 355.3L327.4 354.5L326.3 354.3L325.3 353.9L324.6 353L324.5 351.9L324.5 350.8L324.3 349.7L324.1 348.6L323.1 348.9L322.6 347.9L322.4 349L322.2 350.1L321.4 350.9L322.1 351.7L322.9 350.9L322.9 352L322 352.7L322.8 353.5L323.5 354.4L323.3 355.5L322.3 355.1L321.6 354.2L320.5 354.6L319.7 355.2L318.7 355.8L318.1 356.8L318.3 357.9L317.2 358L317.2 356.9L316.6 356L315.5 355.5L314.7 354.8L313.6 354.8L312.6 354.5L312.8 353.3L311.8 352.8L311.6 351.7L311.7 350.6L311.1 349.7L311.6 348.7L312.5 348.1L313.5 348.4L314.1 347.5L313.4 346.7L314.4 347L314.5 345.9L313.4 345.7L312.4 346.3L311.3 346.1L310.3 345.9L309.5 345.2L308.5 344.7L307.7 343.9L306.7 343.3L306.7 342.2L306.9 341.1L306.7 340L306.6 338.9L306.5 337.8L307.3 337L308.4 336.8L309.4 337.2L310.4 336.7L310.8 335.6L310.3 334.6L310.1 333.5L309.5 332.6L310.1 331.7L311.2 332.1L311.8 333L312.9 333.1L313.6 334L313.6 335.1L313.3 336.1L312.7 337.1L312.4 338.1L313.2 338.9L314.3 338.7L314.8 339.7L314.9 340.9L315.9 340.5L316.4 341.5L317.5 341.6L318.6 341.6L319.2 342.6L320.3 342.5L321.4 342.1L320.8 341.2L321.1 340.1L321.9 340.9L322.3 342L322.6 340.9L323 339.8L324 339.4L325.1 339.2L326.2 338.9L325.1 338.9L324 338.9L323 338.3L321.9 338.5L321.2 337.7L320.9 336.6L321.9 336.1L320.9 335.6L319.9 335.2L319.2 334.3L320.3 334.3L321.2 333.6L321.8 332.7L320.7 332.6L320.1 331.6L319.2 331L319.9 330.1L319.7 329L318.8 328.3L317.8 327.9L317 328.6L315.9 328.8L314.9 328.2L313.8 328.3L313.3 327.4L312.3 327.8L311.2 327.8L310.5 328.7L309.7 327.8L308.7 327.4L307.8 326.8L307.1 325.9L306 325.8L305.7 324.7L305.5 323.6L304.5 323.1L303.4 323L302.3 323.2L301.3 323.5L300.3 324L299.4 324.7L298.8 325.6L299.2 326.6L298.7 327.6L298.3 328.7L298.3 329.8L299.4 330L300.2 330.8L300.7 331.8L301 332.8L301.1 333.9L300.2 333.4L299.3 334.1L299.8 335.1L300.2 336.1L301.1 335.4L300.5 334.4L301.6 334.2L301.8 335.3L301.2 336.2L300.2 336.6L300.5 337.7L299.9 338.7L298.9 339.2L297.9 339.5L297 340.2L295.9 340.3L294.8 340.6L293.8 341L292.8 341.4L292.3 340.4L293 339.5L292.7 338.4L291.8 337.8L291.9 336.7L292 335.6L292.3 334.6L292.4 335.7L293.2 336.4L293.2 337.5L293.8 338.4L293.9 339.5L294.8 340.1L296 340.1L296.8 339.3L296.7 338.2L296.6 337.1L297.2 336.2L296.8 335.1L295.7 334.9L295.4 333.9L295.7 332.8L295.7 331.7L296.2 330.7L297.3 330.5L298 329.6L297 329.1L295.9 329.5L294.8 329.2L294.2 330.2L293.8 331.2L293 332L292.7 330.9L292.9 329.9L292.9 328.7L292.4 327.8L291.7 326.9L290.6 326.7L289.8 325.9L288.8 325.5L289 324.4L288.1 323.9L287.4 323L286.8 322.1L286.4 321.1L285.4 320.6L284.4 320.1L284.8 319L284.4 318L283.3 318L282.9 317L282.4 316L281.9 315L280.8 314.7L279.8 314.2L279.1 313.3L278 313.5L277.3 314.3L276.5 315.1L275.4 315.5L274.9 316.5L274 317.1L273 317.6L272 318.1L271 317.7L269.9 317.4L271 317.8L271.9 318.3L272.9 317.8L273.9 317.2L274.9 316.9L275.4 315.9L276.5 315.5L277.4 314.9L278.5 314.5L279.5 314.7L280.5 315.3L281.2 316.1L282.2 316.7L282.6 317.7L283.1 318.7L284.2 318.8L283.2 319.2L282.6 320.1L282.8 321.2L283.7 321.9L284.7 321.5L285.7 321.6L286.8 322.5L286.5 323.6L286.8 324.7L287.7 325.3L287.9 326.4L287.9 327.5L287.5 328.6L288.4 329.3L289.4 329.8L289.5 330.9L289.1 331.9L289.1 333L288.2 333.7L287.9 334.8L287.1 335.6L287.3 336.7L287 337.7L287.3 338.8L287.7 339.8L287.8 340.9L288.2 341.9L287.2 342.5L286.1 342.4L285.6 341.4L285.2 340.4L284.8 339.4L284.4 338.3L283.5 338.9L283.8 340L283.6 341.1L283.3 342.1L283 343.2L283.8 344L284.8 344.4L285.4 345.4L284.7 346.2L283.7 346.5L283.5 347.6L282.5 348.1L282.2 349.2L281.7 350.2L281.4 351.3L281.5 352.4L281.6 353.5L282.2 354.4L282.6 355.4L282.7 356.5L282.6 357.6L282.1 358.6L281.6 359.6L281.4 360.7L280.9 361.7L279.9 362.1L278.8 361.8L277.7 361.8L276.7 362.3L275.2 363.3L273.7 363.2L272.1 363L271 363L270.7 364.1L270.2 365.1L270.3 366.1L269.3 365.8L268.6 364.9L267.5 365L266.4 365.1L265.8 366L266.7 366.8L267.6 367.5L268.6 367.9L269.5 368.6L269 369.6L268.7 370.7L267.8 371.3L267.4 372.4L266.8 373.4L266.4 374.4L267.2 375.2L266.8 376.3L265.9 375.6L264.9 376.1L263.9 375.4L263 376.1L261.9 376L261.4 375.1L260.7 374.2L260.7 375.3L260.3 376.4L261.4 376.2L262 377.1L263.1 376.9L264.1 377.4L265 378L265.5 378.9L264.9 379.9L264 380.6L263.4 381.5L262.6 382.3L262.6 383.4L261.9 384.3L260.8 384.5L260.1 385.4L259.6 384.4L259.5 383.3L258.7 384.1L258.4 385.2L258.5 386.3L258.2 387.4L258.3 388.5L259.3 388.2L260.3 387.6L260.5 388.7L260.1 389.7L259.7 390.7L258.8 391.4L257.9 392.1L257.2 392.9L256.1 393.2L255 393.3L254.1 394L254.8 393.1L254.6 392L253.9 391.2L252.9 390.7L251.8 390.4L250.8 390.8L250 391.5L248.9 391.1L248 391.8L247.4 392.7L246.3 392.8L245.6 392L245.3 390.9L244.9 389.9L243.8 389.8L243.3 390.8L242.8 389.8L242.9 388.7L241.8 389.1L241.6 388L241 387.1L239.9 387.4L239.1 386.7L239.2 385.6L238.4 384.9L237.3 384.3L236.3 383.9L235.3 383.5L234.4 384.1L233.4 383.5L232.4 384L231.9 385L230.9 384.6L230 385.2L229 384.6L227.9 384.6L226.8 384.5L225.7 384.5L224.7 384.2L223.9 383.4L223 382.9L221.8 382.9L220.9 383.5L220.5 384.5L219.5 385L218.5 384.8L217.8 383.9L217.3 382.9L217.7 381.8L217.1 380.9L216 380.5L214.9 380.6L213.8 380.9L213.5 381.9L213.5 383L213.5 384.1L212.7 384.9L211.9 384.1L211.5 383.1L210.5 382.8L210.1 381.7L209.1 382.4L209.4 383.4L208.4 383.1L207.5 383.7L206.8 384.6L207 385.7L206 386.2L205.6 385.2L204.5 385.5L203.8 386.3L202.7 386L202.2 387L202 385.9L201.9 384.8L202.1 383.8L202.3 382.7L202 381.6L201.6 380.6L201.5 379.5L201.6 378.4L200.6 377.8L200.5 376.8L199.7 375.9L199.7 374.8L199.3 373.8L198.5 373L198 372L197.3 371.1L196.2 371L195.4 371.7L194.4 371.1L191.5 367.8L189 365L189.7 364.2L189.6 363.1L188.6 362.7L187.6 362L187.4 361L187.6 359.9L186.9 359L187.1 357.9L186.4 357.1L186.7 355.9L186 355L185.6 354L184.5 353.9L183.7 353.1L183.6 352L182.9 351.2L182.5 350.2L181.6 349.6L181.5 348.5L181.9 347.4L180.8 347.2L179.9 347.9L179.1 347.1L178.5 346.2L177.5 345.7L177.8 344.6L178.1 343.6L178.9 342.8L178.3 341.8L177.3 341.4L176.2 341.4L175.9 340.3L175.4 339.3L174.6 338.6L173.9 337.8L173.7 336.7L173 335.8L172.2 335L171.1 334.8L170.1 335.3L169.1 335.7L168 335.7L167 336.1L166.4 335.2L166.4 334.1L166.3 332.9L166.2 331.9L165.6 330.9L165.4 329.8L164.5 329.1L163.6 328.5L163.3 327.5L162.7 326.5L162.5 325.4L162.3 324.3L161.7 323.4L161.5 322.3L161.3 321.2L161.2 320.1L160.9 319.1L160.5 318L159.5 317.5L158.9 316.6L158.7 315.5L159.4 314.7L159.5 313.6L158.8 312.8L158.5 311.7L158.3 310.6L157.8 309.6L157.8 308.5L157.8 307.4L156.9 306.7L155.8 306.8L155.5 305.7L155.4 304.6L154.4 304.2L153.4 303.9L152.6 304.7L151.5 304.7L151 303.7L152 303.4L152.9 302.7L153.1 301.6L153.6 300.6L153.4 299.5L152.5 298.9L152.1 297.9L151.5 297L151.3 295.9L150.3 295.3L150.8 294.3L150.6 293.1L150.3 292.1L149.5 291.4L149.7 290.3L150 289.2L150.1 288.1L149.8 287.1L149.3 286.1L149.3 285L149.1 283.9L148.4 283L148.7 281.9L148 281.1L147.8 280L147.3 279L146.6 278.1L146.6 277L147.2 276.2L147.6 275.1L147.7 274L147.4 272.9L147.2 271.9L146.5 271L146.2 269.9L146 268.8L146.1 267.7L145 267.3L145.6 266.3L146.7 266.7L147.4 267.5L147.8 268.6L148.4 269.5L148.2 270.5L149.1 271.2L149.2 272.3L150.3 272.7L150.4 273.8L150.8 274.8L151.7 274.2L152.8 274.3L153.1 275.4L154.1 275L154.1 276.1L154.1 277.2L154.7 278.1L155.5 278.8L156.5 279.4L157.4 280L158.2 280.8L159 281.5L159.8 282.3L160.9 282L161.6 282.8L162.4 283.6L162.8 284.6L163.4 285.6L163.2 286.7L163.1 287.8L163.6 288.8L163.8 289.8L164.1 290.9L164.3 292L164.2 293.1L164.3 294.2L164.7 295.2L165.1 294.2L164.8 293.1L165.1 292L164.9 290.9L164.8 289.8L164.6 288.7L163.7 288.1L164.5 287.3L165.5 286.8L166.5 287.2L167.4 287.8L168.2 288.6L169.3 288.3L170.4 288.1L171.4 288.6L172.4 289L173.6 289L174.2 288.1L175.2 288.3L176.2 287.6L177.2 288L176.2 287.5L175.2 288.1L174.3 287.6L174.1 288.7L173 288.7L171.9 288.7L171 288L169.9 287.8L169 288.4L168 288L168.1 286.9L168.4 285.8L168.9 284.8L168.9 283.7L169.5 282.8L169.5 281.7L170.4 281L169.6 280.3L168.9 281.1L168.4 282.1L167.3 282L168.2 281.4L168 280.3L167.5 279.3L166.7 278.5L166.1 279.5L165.7 280.5L164.9 279.8L164.4 278.9L164.2 277.8L163.2 277.3L162.2 276.9L161.9 275.9L161.5 274.8L160.6 274.2L159.8 273.3L159.2 272.4L158.5 271.4L157.8 270.6L157.9 269.4L158 268.4L158.1 267.2L157 267.7L156.9 266.6L157.4 265.6L156.9 264.5L155.7 264.1L155.6 263L154.5 262.8L154.4 263.9L153.9 264.9L152.9 265.3L152 266L151.4 267L152.2 267.8L152.4 266.7L152.6 267.8L152.7 268.9L151.9 269.7L150.8 269.5L150 268.7L148.8 268.8L148.7 267.7L149.5 266.9L150.1 265.9L150.6 264.9L150.8 263.8L150.9 262.7L151 261.5L151 260.4L151 259.3L150.9 258.2L150.7 257.1L150.5 256L150.3 254.9L150 253.8L149.6 252.7L149.2 251.7L148.9 250.6L148.4 249.6L148 248.5L147.6 247.5L147.1 246.5L146.7 245.4L146.2 244.5L145.5 243.6L144.7 242.8L143.8 242.2L143 241.4L142.1 240.8L141.6 239.8L140.9 238.9L140.2 238.1L139.3 237.5L138.6 236.6L138.2 235.6L137.7 234.6L137.2 233.6L136.3 232.9L135.6 232.1L134.9 231.2L134.3 230.3L134.2 229.2L133.4 228.4L133.1 227.3L132.5 226.4L131.8 225.5L131.1 224.6L130 224.4L128.9 224.7L128.3 223.8L128.1 222.7L127.8 221.6L128.6 220.9L128.2 219.8L127.6 219L127.4 217.9L127.2 216.8L127.1 215.7L126.7 214.6L126.4 213.6L126 212.5L125.5 211.6L125 210.6L124.5 209.6L124 208.6L123.5 207.6L122.9 206.6L122.4 205.7L121.7 204.8L121.2 203.8L120.7 202.9L120.1 201.9L119.7 200.9L119.1 200L118.1 199.4L117.4 198.6L117.4 197.5L118.5 197.4L119.1 196.5L119.2 195.4L119.1 194.3L118.8 193.2L118.4 192.1L117.8 191.2L117 190.4L116.4 189.5L116.3 188.4L115.4 187.7L115.1 186.7L114.8 185.6L114.5 184.5L114 183.6L113.2 182.8L113 181.7L112.9 180.6L113.3 179.5L113.2 178.4L113 177.3L112.5 176.3L112.1 175.3L112.4 174.3L111.9 173.3L111.7 172.2L112.2 171.2L112.3 170.1L112.2 168.9L111.9 167.9L111.4 166.9L111.1 165.8L110.2 165.2L109.3 164.5L109 163.5L108.3 162.6L108.9 161.6L109.4 160.6L109.2 159.5L109.5 158.4L109.2 157.4L108.7 156.3L108 155.5L109.1 155.1L109.7 154.2L110.7 153.7L110.6 152.6L111.7 152.9L112.8 153L113.4 152L113.9 151L114.2 149.9L114.5 148.8L114.7 147.7L114.6 146.6L113.9 145.8L113.9 144.7L113.9 143.5L114.1 142.5L114.3 141.4L114.5 140.3L114.1 139.2L113 139.1L112.9 137.9L112.7 136.8L112.5 135.8L113.1 134.8L113.7 133.8L113 132.9L113.2 131.8L114 131.1L115 130.5L115.5 129.6L115.7 130.7L116.2 131.7L116.7 132.7L117 133.8L117.7 134.7L118.6 135.3L118.2 136.4L118.4 137.5L119.1 136.6L119.3 135.5L120.4 135.8L121 136.7L122 136.4L123 136.9L123.2 138L124.2 138.3L125.2 138.8L126.2 139.2L127.4 139.2L128.3 139.8L129.4 139.7L130.5 139.5L131.5 139.2L132.5 138.7L133.3 139.5L133.4 140.6L134.6 140.6L134.1 141.6L135 141L135 142.1L136.2 141.9L136.4 140.8L136.5 139.7L137.5 140.2L138.2 141.1L139 141.8L140 142.3L140.8 143.1L142 143.3L143 143.7L144.1 143.8L145.2 143.9L146.3 143.9L147.4 143.7L148.6 143.4L149.6 142.9L150.8 142.4L151 141.4L151.3 140.3L151.4 139.2L150.8 138.2L150.2 137.3L150.3 136.2L151.4 136.6L151.7 137.7L152.8 137.9L153.3 138.9L153.5 140L152.6 140.7L152.1 141.7L152 142.9L152.7 143.8L153.1 144.8L153.7 145.7L154.3 146.7L155.1 147.4L156.1 148L157.2 148.1L158.3 148L159.4 148L160.3 148.5L161.3 149L162.2 149.6L163.3 149.9L164.4 149.8L165.5 149.5L166.4 148.8L167.3 148.2L167.4 149.3L168.1 150.2L168.1 151.3L169 152L169.8 152.7L170.4 153.6L171.5 153.6L172.6 154L173.5 154.6L174.5 155L175.6 155.3L176.6 155.8L177.7 155.8L178.8 155.8L179.9 156L180.9 156.4L182 156.7L181.6 157.7L181.7 158.8L182.2 159.8L183.2 160.4L184.1 160.9L185 161.6L185.5 162.6L186.3 163.3L187.3 163.9L188.3 164.4L189.4 164.6L190.5 164.7L191.6 164.7L192.6 165.2L193.6 165.5L193.9 166.5L194.9 167L196 166.9L197.1 166.8L198 167.4L199 167.8L200 168.4L200.8 169.1L201.8 169.7L202.7 170.2L203.9 170.2L204.4 171.1L205.5 171.4L206.5 171.8L207.6 172L208 173L209 173.5L210.1 173.6L210.7 174.6L209.7 175.2L208.6 175.1L207.6 174.9L206.5 175L205.4 175.2L206.5 175.1L207.5 174.9L208.5 175.5L209.6 175.6L210.5 175.1L210.8 174L211.7 174.6L212.8 174.5L213.9 174.7L214.9 175.2L216 175L217 174.7L218 175.2L219.1 175.3L220.2 175L221.3 174.9L222.2 175.5L223.3 175.6L223.5 176.7L223.6 177.8L223.3 178.8L222.7 179.7L223.8 179.8L224.2 180.8L225.2 181.3L224.7 180.3L224.2 179.3L223.9 178.3L223.8 177.1L224 176L225.1 176.1L226.2 176.2L227.2 175.8L228.4 175.3L229.5 175.3L230.6 175.1L231.6 174.6L232.5 174.1L233.5 173.5L234.3 172.7L234.6 171.7L235.5 172.3L235.4 173.4L235.4 174.5L236.1 175.3L236.5 176.4L237.1 177.2L236.8 178.3L237 179.4L237.5 180.4L236.9 181.4L237.4 182.3L237.6 181.3L238.1 180.3L238.7 181.2L239 182.2L238.8 183.3L239.2 182.3L239.3 181.2L239.3 180.1L238.5 179.3L237.7 178.5L237.8 177.4L238.1 176.3L238.9 175.6L239.7 174.9L238.6 175.1L237.5 175.3L236.9 174.4L238 174.2L239 173.8L240 173.3L240.9 172.6L241.5 171.7L242.3 170.9L242 169.8L243.1 169.6L244.1 170.1L245 169.5L245.9 168.8L246.6 167.9L246.2 166.9L247.2 167.4L248.1 168L249 168.6L250 167.9L250.9 166.7L251.7 166L252.5 166.7L253.5 166.2L254.1 165.2L255.1 164.7L256 164L256.9 163.5L258 163.1L258.9 163.8L260 163.8L261.1 163.6L262.1 163.3L263 162.6L263.8 161.9L264.6 161.1L265.2 160.1L266.2 159.8L267.3 159.8L268.4 160.2L269.5 160.1L270.1 161L271.2 160.9L272.3 161L273.4 161.2L274.4 161.7L275.3 162.3L276.3 161.8L277.4 161.8L278.3 161.1L279.4 160.9L280.3 160.3L281 159.4L281.6 158.4L282 157.5L282.9 156.8L283.9 156.2L284.6 157.1L285.7 157.4L286.7 157.1L287.6 156.4L288.7 156.5L288.9 157.6L289.2 158.6L290.2 159.2L291.2 159.7L291.4 160.8L292.2 161.6L293.2 161.7L294.4 161.4L295.4 161L296.4 160.4L297.3 159.8L298.2 159.1L299 158.3L299.7 157.5L300.4 156.6L301 155.6L301.7 154.7L302.3 153.7L302.8 152.7L303.5 151.8L303.9 150.8L304.4 149.8L304.8 148.8L305.2 147.8L306.3 147.7L307.3 147.2L308.2 146.5L309.1 145.9L310.2 146.3L311.1 147L311.4 148L312.2 148.8L313.3 149L314.4 148.7L315.5 148.6L316 149.6L316.8 150.4L317.9 150.8L318.9 151L320 151.2L321.2 151L322.2 150.6L323.1 149.9L324 149.3L324.7 148.4L325.4 147.6L326.1 146.6L326.7 145.7L327.2 144.7L327.7 143.7L328.1 142.7L327.9 141.6L328.7 140.8L328.9 139.7L327.8 139.4L327.5 138.3L328.5 138.7L329.6 138.5L330.7 138.5L331.8 138.7L332.7 139.3L333.7 139.8L334.4 140.6L335.5 141.1L336.6 141L337.5 141.7L338.2 142.5L338.6 143.5L339.2 144.5L339.9 145.3L340.7 146.1L341.7 146.6L342.9 146.4L343.2 145.4L343.8 146.3L344.7 147.1L345.7 147.6L346.1 148.7L346.2 149.7L346.9 150.7L347.9 151.2L348.8 151.8L349.2 152.9L349.5 153.9L350.1 154.9L350.9 155.7L351.4 156.7L351.6 157.8L352.4 158.6L352.7 159.6L353.5 160.4L354.6 160.5L353.6 161L352.8 161.8L352.2 162.7L351.6 163.7L351.1 164.7L350.9 165.8L350.7 164.7L349.7 164.2L348.8 164.9L349.5 165.8L350.5 166.3L350.9 167.3L350.6 168.4L350.3 169.5L349.8 170.5L349.5 171.6L349.3 172.7L349.4 173.8L349.8 174.8L350.3 175.8L349.7 176.8L349.4 178L349.6 179.1L350.2 180L350.3 181.1L350.7 182.1L351.3 183.1L352.4 183.2L353.5 183.3L353.6 184.4L353.3 185.5L352.4 186.2L352 187.2L351.3 188L351.1 186.9L350.4 186L349.7 186.9L349.6 188L349.7 189.1L348.8 189.6L347.7 189.9L348.6 190.5L349.5 191L350.3 190.2L351.3 189.7L352.1 188.9L352.3 187.8L353.1 187L353.4 186L354.5 185.6L354.2 186.7L353.5 187.5L353 188.5L352.7 189.6L352.5 190.7L352.2 191.8L351.7 192.7L351.2 193.7L350.8 194.8L350.7 196L350.3 197L349.9 198.1L349.8 199.1L349.5 200.2L349.2 201.3L349.1 202.4L349.1 203.5L349.2 204.7L349.7 205.7L350 206.7L350.1 207.9L350.4 209L350.6 210.1L351.5 210.7L352.3 211.5L352.5 212.6L352.6 213.7L352.6 214.8L352.7 215.9L352.3 216.9L351.7 217.8L351.1 218.7L350.7 219.8L350.6 220.9L350.8 222L350.5 223.1L350.3 224.3L350.5 225.4L351.1 226.4L351.3 227.4L350.3 227.9L349.9 229L349.5 230L349.1 231.1L349 232.3L349.1 233.4L349.2 234.6L349.5 235.7L350.1 236.7L350.8 237.5L351.8 237.9L351.6 239L351.9 240L352.6 240.9L352.9 242L352.4 242.9L351.5 243.7L351.5 244.8L352 245.8L351.1 246.4L350.7 247.5L350.5 248.6L350.3 249.7L350.3 250.8L350.3 252L350.5 253.1L351.1 254L352.1 254.5L352.4 255.6L352.9 256.5ZM315 62.1L315.7 61.6L316.4 61.1L316.5 60.3L317.3 59.9L318.2 59.6L318.5 58.8L319.3 58.5L320.2 58.4L321 58.6L321.5 57.9L321.6 57.1L321.1 56.3L321.7 55.7L322.4 55.2L322.8 54.5L322.6 53.7L322.6 52.8L321.9 52.2L321.5 51.5L322.3 51.1L323 51.5L323.7 52.1L324.5 51.7L325.1 51L325.8 50.7L326.5 50.2L327.1 49.6L327.5 48.8L328.4 48.7L329.2 49.1L328.7 49.8L328.7 50.6L328.9 51.5L329.2 52.3L329.4 53.1L329.5 52.3L330.2 52.7L330.7 53.4L330.4 52.6L329.8 51.9L329.5 51.1L329.1 50.4L329 49.6L329.5 50.3L329.9 51L330.4 51.8L330.9 52.5L331.5 53.1L332.1 53.7L332.6 54.4L333.1 55.2L333.5 56L334 56.7L334.6 57.4L335.1 58.1L335.7 58.7L336.3 59.4L336.9 60.1L337.4 60.7L338 61.5L338.5 62.3L339 63L339.5 63.7L340 64.4L340.5 65.1L341 65.8L341.6 66.4L342.3 67.1L342.9 67.7L343.6 68.2L344.3 68.6L345.1 68.2L345.8 68.7L346.5 69.2L347.3 69.6L348.1 69.9L348.9 70.2L349.8 70.2L350.6 70L350.5 70.8L350.3 71.7L350.1 72.5L350 73.4L350 74.2L350 75.1L350.2 76L350.3 76.8L350.4 77.7L350.4 78.6L350.5 79.4L350.5 80.3L350.6 81.2L350.8 82.1L350.9 82.9L351.2 83.7L351.4 84.6L351.6 85.4L351.8 86.2L352.1 87L352.2 87.9L352.4 88.7L352.8 89.5L353.1 90.3L353.5 91.1L353.1 91.9L352.5 92.4L351.7 92.9L350.9 93.2L350.1 93.4L349.5 92.8L349.2 92L348.5 91.5L347.6 91.8L346.8 91.5L346 91.6L345.1 91.9L344.5 92.5L344.2 93.3L343.9 94.1L343.9 94.9L343.1 95.3L342.4 95.8L341.8 96.4L341 96.4L340.1 96.6L339.6 97.2L338.9 96.7L338.1 96.3L337.4 96.8L337 96L336.2 95.7L335.6 95.1L334.8 95L334.4 94.2L334.2 93.3L333.4 93.2L333.1 92.4L333.9 92L334.3 91.2L334.2 90.4L333.8 89.6L333.3 88.9L332.8 88.2L332.6 87.3L332.7 86.5L332.7 85.6L332.6 84.7L332.5 83.9L332.3 83L332 82.2L331.2 81.8L330.6 81.2L329.9 80.7L329.5 80L328.6 80.2L329.2 80.8L328.7 81.5L328.5 80.6L328.5 79.8L328.4 78.9L328.1 78.1L327.8 77.3L327.5 76.4L326.8 76L326 75.7L325.2 76.1L324.4 76L323.8 75.4L323.1 74.9L322.3 75.1L322.7 74.4L323.5 74.2L324 73.5L324.7 73L325.2 72.3L325.2 71.4L325.4 70.6L325.3 69.7L325.1 68.9L324.9 68L324.6 67.2L324.2 66.4L323.8 65.6L323.2 65L322.6 64.3L321.8 64.1L321 64.4L320.2 64.7L319.5 65.1L318.8 65.7L318.4 64.9L317.8 64.3L317 63.9L316.3 63.5L315.5 63.3L315.3 62.4ZM56.7 65.6L56.9 64.8L57.1 64L57.5 63.2L57.5 62.4L57.8 61.6L58.1 60.8L58 59.9L58.7 59.4L58.9 58.5L58.7 57.7L58.4 56.9L58.5 56L58.5 55.2L58.5 54.3L58.2 53.5L57.8 52.7L57.8 51.9L58 51L58 50.2L57.7 49.4L57.4 48.6L57.5 47.7L58.4 47.6L59.1 47.1L59.8 46.6L60.6 46.3L61.2 45.7L61.8 45.1L62.3 44.4L62.7 43.6L63 42.8L63.2 42L63.3 41.1L63.1 40.3L63 39.4L62.8 38.6L62.8 37.7L63.4 37.2L63.7 36.4L64.6 36.2L65.2 36.8L66 37.1L66.5 37.8L67.3 38L68.2 38.2L68.8 38.8L69.5 39.3L70.3 39.7L71.1 40.1L71.5 40.9L72.1 41.5L72.7 42.1L73.3 42.7L74 43.3L74.7 43.8L74.9 44.7L74.8 45.6L74.7 46.4L74.6 47.3L74.5 48.2L74.4 49.1L74.3 50L74.3 50.9L74.3 51.8L74.4 52.6L74.5 53.5L74.7 54.4L75 55.2L75.3 56L75.7 56.8L76.1 57.5L75.9 58.4L75.6 59.2L75.4 60L74.9 60.7L74.6 61.6L74.5 62.4L74.6 63.3L74.7 64.2L74.8 65.1L75.4 65.7L76.2 66.2L76.7 66.8L76.7 67.7L76.5 68.5L76.4 69.4L76.4 70.3L76.4 71.1L76 71.9L75.9 72.7L75.4 73.4L75.3 74.3L74.8 75L74.3 75.6L74.4 76.5L74 77.3L73.1 77.4L72.3 77.6L71.8 78.3L71.8 79.2L70.9 79L70.7 79.9L70.1 80.5L69.4 81L68.6 81.3L68 81.8L67.1 81.7L66.4 82.1L66.3 83L65.4 82.9L64.6 82.8L63.9 83.4L63.4 84.1L62.7 84.5L62.5 85.4L63 86L62.8 86.9L62.3 86.2L61.7 85.6L61.1 85L61.6 84.3L61 83.7L60.1 83.8L59.5 83.2L59.5 82.4L59.3 81.5L59.1 80.7L59 79.9L58.7 79.1L59.4 78.6L60.2 78.2L60.3 77.4L60.1 76.5L60 75.6L60.2 74.8L60.6 74L60.2 73.3L60.3 72.4L60.1 71.6L59.9 70.7L59.3 70.1L59 69.3L58.4 68.7L57.8 68.1L57.2 67.5L57.4 66.7L56.7 66.2ZM274.9 380.8L274.5 380L274.5 379.2L274.6 378.3L274.3 377.5L273.7 376.9L273.2 376.2L272.5 375.7L271.9 375.1L271.7 374.3L272.2 373.6L273 373.7L273.7 374.2L274.1 375L274.5 375.7L274.9 376.5L275.5 377.1L276 377.8L276.8 378.1L277.5 377.6L277.2 376.8L277.1 375.9L277.8 375.4L278 374.5L277.2 374.7L277.2 373.8L276.7 373L277.1 372.3L277.7 371.7L277.7 370.8L277.6 370L277.5 369.1L277.8 368.3L278.2 369.1L278.7 369.8L278.7 370.6L279.4 371.1L280 370.5L280.1 369.6L281 369.5L280.8 368.7L280.5 367.8L280.5 367L281.2 366.5L281.5 365.7L281.6 364.8L282.1 364.1L282.8 363.7L283.5 363.1L283.5 362.3L283.7 361.4L284.4 360.9L284.6 360.1L284.7 359.2L285.2 360L285.4 360.8L285.3 361.6L285.6 362.4L285.7 363.3L286.6 363.3L287.4 362.6L287.9 362L288.4 361.2L288.9 360.5L289.2 359.6L289.1 358.8L289.1 357.8L288.5 357.2L288.9 356.5L289.5 355.8L290.1 356.3L290.8 355.8L291 354.9L291 354L290.7 353.2L289.9 352.9L289.3 353.6L288.4 353.7L287.6 353.6L287.9 352.8L287.2 352.3L286.6 352.9L285.8 353.2L285.4 352.4L284.5 352.4L283.8 352L284.3 351.3L285 350.8L284.4 350.2L285.1 349.7L285.9 349.3L286.5 349.9L287.1 350.5L287.6 349.8L288.2 349.2L288.9 349.7L289.3 348.9L289.3 348.1L288.6 348.7L288.2 347.9L287.5 348.5L287.4 347.7L286.5 347.8L285.8 347.3L286.5 346.8L286.8 346L287.1 345.2L287.8 344.7L288.4 344L288.8 343.2L289.6 343.4L289.7 344.2L289.6 345.1L290.4 345.4L290.5 346.3L291 347L291.3 347.8L291.9 348.4L291.9 349.3L291.5 350.1L291.4 351L291.5 351.8L292.4 352L292.6 352.9L292.7 353.7L292.7 354.6L293 355.4L293.8 355.8L294 356.6L294.2 357.5L294.1 358.3L293.9 359.2L293.2 358.7L292.3 358.6L291.5 359L290.7 359.4L289.9 359.9L289.3 360.5L288.7 361.1L288.1 361.8L287.5 362.7L287.1 363.4L286.8 364.2L286.8 365.1L286.9 365.9L287 366.8L286.8 367.6L287.1 368.4L287.4 369.2L288.1 369.7L288.9 369.4L289.4 368.8L290.3 368.7L290.7 369.5L290.7 370.3L290.5 371.2L290.1 371.9L289.4 372.4L288.7 372.9L288.5 373.8L288 374.5L288.3 375.2L287.9 376L287.3 376.6L287.1 377.5L286.9 378.3L286.7 379.2L287 380L287.1 380.8L286.9 381.7L286 381.8L285.5 382.5L284.8 382.1L284 381.8L283.5 381.1L283 380.4L282.2 380.7L281.8 379.9L281.8 379.1L281.5 378.2L282.4 378L282.3 377L281.8 376.3L281 376.2L280.2 375.8L279.2 375.9L278.7 376.5L279 377.4L278.4 378L277.7 378.5L277.6 379.4L277.6 380.2L276.8 380.4L276 379.9L275.5 380.6ZM349.2 102.7L349.7 102L350.1 101.2L351 101.3L351.8 100.9L352.5 100.4L353 99.7L353.4 98.9L353.9 99.6L354.5 100.2L354.9 101L355.5 101.6L355.7 102.4L356.1 103.2L356.9 103.6L357.5 104.3L357.9 105L358.5 105.6L359.3 105.9L360.1 106L360.9 106.4L361.1 107.2L361.1 108.1L361.2 108.9L361.8 109.5L362 110.4L362.6 111L363.4 111.4L362.8 112L362 111.8L361.2 111.5L360.4 111.9L360 112.7L360.2 113.5L359.4 113.8L358.6 114.1L358 114.7L358 115.6L357.2 116L356.9 115.2L356 115.2L355.3 115.7L354.8 116.3L354 116L353.8 115.1L353.8 114.3L353.5 113.5L353.2 112.7L352.7 111.9L352.4 111.2L351.6 110.8L351 111.3L350.3 110.8L349.6 111.2L349.2 111.9L348.5 112.5L348 113.2L347.2 113.6L346.5 114.1L345.8 113.6L345.5 112.8L345.2 112L344.5 111.6L343.7 111.9L343 112.4L342.2 112.6L341.5 113.1L340.8 113.6L341 112.8L340.5 112.1L339.7 111.8L339.1 112.5L338.3 112.6L337.4 112.9L336.7 113.2L335.8 112.9L335 112.6L334.4 112.1L334.4 111.2L333.6 111L333.5 110.2L332.8 109.6L332 109.8L331.3 110.4L330.7 109.8L330.8 109L330.9 108.1L330.7 107.3L331.2 106.7L332 106.4L332.6 105.8L333.5 105.5L333.9 104.8L334.7 104.4L335.5 104.7L336 104L336.7 103.5L337.5 103.5L338.3 103.2L339.2 103.2L339.9 102.8L340.8 102.7L341.4 103.3L342.3 103.4L343.1 103.7L343.9 103.7L344.7 104.1L345.2 103.3L345.4 102.5L345.5 101.7L346.3 101.4L346.6 102.2L347.4 101.9L348.1 102.4L348.9 102.7ZM342.3 306.5L341.8 306.8L341.3 307.3L341.2 307.9L340.6 307.7L339.9 307.8L339.4 308.1L339.1 307.6L338.4 307.5L337.8 307.5L337.1 307.5L336.5 307.9L336.2 308.5L336.1 309.1L336.4 309.7L337 309.7L337.3 310.3L337.4 310.9L337.8 311.4L337.7 312.1L337.7 312.7L337.1 313L336.4 312.8L335.9 312.5L336 313.1L335.4 313.1L334.8 312.9L334.2 313.3L333.8 313.8L333.3 314.2L332.7 314.5L332.4 313.9L332.5 313.3L332.5 312.6L333 312.2L333.4 311.7L333.6 311.1L333.9 310.5L334.1 309.9L334.5 309.4L335.1 309.6L335.7 309.4L335.9 308.8L335.9 308.2L335.6 307.6L335.1 307.1L334.5 307L334.1 307.5L333.6 307.9L333 307.9L332.4 307.5L333 307.3L333.6 307L334 306.5L334.1 305.8L333.8 305.2L333.3 304.9L333.5 304.2L334 303.8L334.3 303.2L334.7 302.7L334.8 302.1L334.9 301.5L335 300.8L335.6 300.5L335.9 299.9L336.3 299.4L336.8 299.8L337.1 300.4L337.6 300.8L338.3 300.6L338.9 300.6L339.5 300.9L339.7 301.5L340.1 302.1L340.4 302.6L340.4 303.3L340.6 303.9L340.9 304.5L341.1 305.1L341.5 305.6L342.1 305.9L342.6 306.3ZM124.9 136.7L125.3 136.2L125.5 135.6L125.3 134.9L125.2 134.3L125.1 133.6L125.1 133L125.5 132.4L126 132L126.5 131.6L127 131.1L127.4 130.6L127.8 130.1L128 129.5L128.1 128.8L128.3 128.2L128.9 128L129 128.6L129.3 129.2L129.2 129.8L129.6 130.3L130.2 130.5L130.9 130.7L131.4 131.1L131.3 130.4L131 129.8L130.7 129.2L130.5 128.6L131 129L131.3 129.6L131.7 130.2L132 130.8L132.3 131.3L132.8 131.8L133.3 132.2L133.9 132.6L134.4 133L135 133.3L135.6 133.4L136.3 133.3L136.9 133L136.5 133.6L136.8 134.2L137.1 134.8L137.5 135.4L137.9 135.8L137.4 136.2L136.7 136.3L136.2 135.9L135.7 135.5L135 135.2L134.4 135.4L133.9 135.9L133.3 135.7L132.7 135.4L132.1 135.4L131.5 135.7L131 136.1L130.5 136.6L130.1 137.2L129.5 137.5L128.9 137.3L128.3 137.3L127.7 137.6L127.4 138.2L126.8 138.2L126.1 138L125.6 137.6L125.3 137ZM342.1 123.9L341.8 123.3L341.3 122.9L340.7 123L340 123.1L339.4 122.9L339.2 122.2L339.4 121.6L339.4 121L339.4 120.3L338.8 120.2L338.1 120.3L337.9 119.7L338.3 119.2L338.6 118.6L339.2 118.3L339.8 118L340.1 117.5L340.7 117.2L341.4 117.1L342 117.1L342.7 117L343.3 116.7L343.8 116.3L344.4 116.3L344.8 116.8L345.2 117.3L345.8 117.2L346.2 116.7L346.5 116.1L346.9 115.7L347.5 115.4L347.9 115.9L347.8 116.5L347.4 117L347 117.5L346.9 118.2L346.8 118.8L346.7 119.5L347.1 120L346.7 120.5L346.4 121.1L345.9 121.5L345.4 121.9L345 122.4L344.6 123L344.3 123.5L344.3 124.2L344.7 124.6L344.1 124.8L343.5 125.1L342.9 124.8L342.6 124.2ZM114.6 118L114.9 117.4L115 116.8L114.6 116.2L114.6 115.6L115.2 115.5L115.7 115.9L116.4 116L117 116.2L117.5 115.8L117.8 115.2L118.1 114.6L118.6 114.1L118.5 113.4L118.1 112.9L118.2 112.2L118.5 111.6L118.7 111L118.9 110.4L119.4 109.9L119.3 109.3L119.5 108.6L119.8 109.2L119.9 109.8L119.8 110.5L119.7 111.1L119.8 111.8L119.7 112.4L119.8 113L119.8 113.7L119.5 114.3L119.8 114.9L119.9 115.5L119.7 116.1L119.7 116.8L119.6 117.5L119.6 118.1L119.4 118.7L119.1 119.3L118.6 119.8L118.6 120.4L118.6 121.1L118.5 121.7L118.5 122.4L118.7 123.1L118.8 123.7L118.8 124.4L118.5 125L118.3 125.6L117.9 126.1L117.2 126L116.8 125.6L116.2 125.3L116 124.6L115.9 124L115.5 123.5L115.6 122.8L115.8 122.2L116 121.6L115.7 121L115.6 120.3L115.5 119.7L115.3 119.1L115.2 118.4L114.7 118ZM122.8 112.2L123.1 111.6L123.1 111L123.7 111.3L124.4 111.2L125 110.9L125.4 110.4L125.8 109.9L126 109.3L125.6 108.7L126 108.2L125.7 107.7L126.2 107.3L126.8 107.3L127.3 107.8L127.9 108.1L128.5 107.8L129.2 107.8L129.8 108.1L130.3 107.7L130.9 108L131 108.6L130.8 109.2L131.1 109.8L131.5 110.3L131.3 110.9L130.8 111.4L130.2 111.6L130.1 112.3L130.1 112.9L130.5 113.5L129.8 113.5L129.5 114.1L129 114.5L128.4 114.8L127.9 115.2L127.3 115.5L126.7 115.7L126.2 115.3L125.6 114.9L125 114.5L124.4 114.4L124 113.9L123.9 113.2L123.5 112.6L122.9 112.4Z"/>
      <path class="tas-network-link town-link" d="M141.8 146.8L193.3 165.7M181.6 159.8L193.3 165.7M204.2 170.8L193.3 165.7M170.3 256.7L193.3 165.7M155.6 239.2L193.3 165.7M168.4 199.4L193.3 165.7M211 174.9L222.7 177M227.3 181.9L222.7 177M236 175.6L222.7 177M221.7 194.8L222.7 177M210 194.8L222.7 177M243.1 207.4L275.3 199.2M254.3 170.3L275.3 199.2M277 211.6L275.3 199.2M298.4 243.3L275.3 199.2M351.9 238.8L275.3 199.2M311.6 229.3L275.3 199.2M300 174.8L275.3 199.2M291.5 160.7L275.3 199.2M263.2 230.1L275.3 199.2M262 186.8L275.3 199.2M348.3 189.3L275.3 199.2M269.7 319.2L287.4 328M302.9 319L287.4 328M286.2 336.4L287.4 328M269 341.2L287.4 328M240.2 316.5L287.4 328M321 352.3L287.4 328M320.8 300L287.4 328M246.4 293.8L287.4 328"/>
      <path class="tas-network-link backbone" d="M193.3 165.7L222.7 177L275.3 199.2L287.4 328"/>
      <g class="tas-node" style="animation-delay:.15s" transform="translate(141.8 146.8)"><circle r="7"/><circle r="3"/><text>Smithton</text></g>
      <g class="tas-node" style="animation-delay:.25s" transform="translate(181.6 159.8)"><circle r="7"/><circle r="3"/><text>Wynyard</text></g>
      <g class="tas-node" style="animation-delay:.35s" transform="translate(204.2 170.8)"><circle r="7"/><circle r="3"/><text>Penguin</text></g>
      <g class="tas-node" style="animation-delay:.45s" transform="translate(170.3 256.7)"><circle r="7"/><circle r="3"/><text>Queenstown</text></g>
      <g class="tas-node" style="animation-delay:.55s" transform="translate(155.6 239.2)"><circle r="7"/><circle r="3"/><text>Zeehan</text></g>
      <g class="tas-node" style="animation-delay:.65s" transform="translate(211 174.9)"><circle r="7"/><circle r="3"/><text>Ulverstone</text></g>
      <g class="tas-node" style="animation-delay:.75s" transform="translate(227.3 181.9)"><circle r="7"/><circle r="3"/><text>Latrobe</text></g>
      <g class="tas-node" style="animation-delay:.85s" transform="translate(236 175.6)"><circle r="7"/><circle r="3"/><text>Port Sorell</text></g>
      <g class="tas-node" style="animation-delay:.95s" transform="translate(221.7 194.8)"><circle r="7"/><circle r="3"/><text>Sheffield</text></g>
      <g class="tas-node" style="animation-delay:1.05s" transform="translate(243.1 207.4)"><circle r="7"/><circle r="3"/><text>Deloraine</text></g>
      <g class="tas-node" style="animation-delay:1.15s" transform="translate(254.3 170.3)"><circle r="7"/><circle r="3"/><text>George Town</text></g>
      <g class="tas-node" style="animation-delay:1.25s" transform="translate(277 211.6)"><circle r="7"/><circle r="3"/><text>Perth</text></g>
      <g class="tas-node" style="animation-delay:1.35s" transform="translate(298.4 243.3)"><circle r="7"/><circle r="3"/><text>Campbell Town</text></g>
      <g class="tas-node" style="animation-delay:1.55s" transform="translate(348.3 189.3)"><circle r="7"/><circle r="3"/><text>St Helens</text></g>
      <g class="tas-node" style="animation-delay:1.65s" transform="translate(269.7 319.2)"><circle r="7"/><circle r="3"/><text>New Norfolk</text></g>
      <g class="tas-node" style="animation-delay:1.75s" transform="translate(302.9 319)"><circle r="7"/><circle r="3"/><text>Sorell</text></g>
      <g class="tas-node" style="animation-delay:1.85s" transform="translate(286.2 336.4)"><circle r="7"/><circle r="3"/><text>Kingston</text></g>
      <g class="tas-node" style="animation-delay:1.95s" transform="translate(269 341.2)"><circle r="7"/><circle r="3"/><text>Huonville</text></g>
      <g class="tas-node map-only" aria-hidden="true" style="animation-delay:.18s" transform="translate(240.2 316.5)"><circle r="6"/><circle r="2.6"/></g>
      <g class="tas-node map-only" aria-hidden="true" style="animation-delay:.28s" transform="translate(321 352.3)"><circle r="6"/><circle r="2.6"/></g>
      <g class="tas-node map-only" aria-hidden="true" style="animation-delay:.38s" transform="translate(320.8 300)"><circle r="6"/><circle r="2.6"/></g>
      <g class="tas-node map-only" aria-hidden="true" style="animation-delay:.48s" transform="translate(246.4 293.8)"><circle r="6"/><circle r="2.6"/></g>
      <g class="tas-node map-only" aria-hidden="true" style="animation-delay:.58s" transform="translate(351.9 238.8)"><circle r="6"/><circle r="2.6"/></g>
      <g class="tas-node map-only" aria-hidden="true" style="animation-delay:.68s" transform="translate(311.6 229.3)"><circle r="6"/><circle r="2.6"/></g>
      <g class="tas-node map-only" aria-hidden="true" style="animation-delay:.78s" transform="translate(300 174.8)"><circle r="6"/><circle r="2.6"/></g>
      <g class="tas-node map-only" aria-hidden="true" style="animation-delay:.88s" transform="translate(291.5 160.7)"><circle r="6"/><circle r="2.6"/></g>
      <g class="tas-node map-only" aria-hidden="true" style="animation-delay:.98s" transform="translate(263.2 230.1)"><circle r="6"/><circle r="2.6"/></g>
      <g class="tas-node map-only" aria-hidden="true" style="animation-delay:1.08s" transform="translate(168.4 199.4)"><circle r="6"/><circle r="2.6"/></g>
      <g class="tas-node map-only" aria-hidden="true" style="animation-delay:1.18s" transform="translate(210 194.8)"><circle r="6"/><circle r="2.6"/></g>
      <g class="tas-node map-only" aria-hidden="true" style="animation-delay:1.28s" transform="translate(262 186.8)"><circle r="6"/><circle r="2.6"/></g>
      <g class="tas-node hub" style="animation-delay:.05s" transform="translate(193.3 165.7)"><circle r="11"/><circle r="5"/><text>Burnie</text></g>
      <g class="tas-node hub" style="animation-delay:.2s" transform="translate(222.7 177)"><circle r="11"/><circle r="5"/><text>Devonport</text></g>
      <g class="tas-node hub" style="animation-delay:.35s" transform="translate(275.3 199.2)"><circle r="11"/><circle r="5"/><text>Launceston</text></g>
      <g class="tas-node hub" style="animation-delay:.5s" transform="translate(287.4 328)"><circle r="11"/><circle r="5"/><text>Hobart</text></g>
    </svg>
  </div>
  <div class="reveal">
    <span class="section-kicker">Local coverage</span>
    <h2>Onsite and Remote IT Support for Tasmanians</h2>
    <ul class="coverage-bullet-list">
      <li>Latrobe and North West based.</li>
      <li>Remote IT support across Tasmania.</li>
      <li>Planned onsite visits where practical.</li>
      <li>Support for businesses and individuals.</li>
    </ul>
    <div class="button-row"><a class="button primary" href="{{root}}contact/">Ask about your area</a><a class="button secondary" href="{{root}}contact/?intent=business-support">Get business support</a></div>
  </div>
</section>
$(GoogleMapSection "TassieTech's Tasmanian service base." "Our Latrobe location anchors local North West onsite support and statewide remote IT support for Tasmanian businesses and individuals.")
$(AreasGrid)
$(FaqSection $areaFaqs)
"@
Add-Page "areas-we-serve" "Areas We Serve | TassieTech Tasmania" "Find TassieTech service areas across Tasmania, including North West towns, Launceston, Hobart, the West Coast, East Coast, Midlands, and Huon Valley." "Areas we serve" "Areas We Serve" "Find local and remote technology support coverage across Tasmanian towns and city hubs." $areasContent "areas"
Add-Page "it-services-tasmania" "IT Services Tasmania | TassieTech" "Tasmanian IT services for businesses and individuals, with North West support and remote help across Burnie, Devonport, Launceston, Hobart, and regional towns." "Tasmania" "IT Services Across Tasmania" "Local technology support for Tasmanian businesses, organisations, and individuals." $areasContent "areas"
Register-Faq "areas-we-serve" $areaFaqs
Register-Faq "it-services-tasmania" $areaFaqs
Register-ServiceSchema "areas-we-serve" "TassieTech Service Areas" "Find TassieTech service areas across Tasmania, including North West towns, Launceston, Hobart, the West Coast, East Coast, Midlands, and Huon Valley." "Tasmanian IT service coverage" "Tasmania"
Register-ServiceSchema "it-services-tasmania" "IT Services Across Tasmania" "Tasmanian IT services for businesses and individuals, with North West support and remote help across Burnie, Devonport, Launceston, Hobart, and regional towns." "Tasmanian IT services" "Tasmania"

$towns = @(
  @{Slug="it-services-for-burnie"; Name="Burnie"; Note="Burnie's busy business community needs reliable systems, secure accounts, and responsive support."},
  @{Slug="it-services-for-wynyard"; Name="Wynyard"; Note="Wynyard businesses can access practical North West support for devices, networks, websites, cloud services, and security."},
  @{Slug="it-services-for-smithton"; Name="Smithton"; Note="Smithton and Circular Head teams can get clear remote-first technology support with onsite options when proximity matters."},
  @{Slug="it-services-for-penguin"; Name="Penguin"; Note="Penguin businesses can access practical North West support for devices, networks, cloud systems, websites, and security."},
  @{Slug="it-services-for-queenstown"; Name="Queenstown"; Note="Queenstown and West Coast teams can access remote-first technology support for business systems, websites, cloud tools, security, and continuity."},
  @{Slug="it-services-for-zeehan"; Name="Zeehan"; Note="Zeehan and West Coast teams can access remote-first technology support for business systems, websites, cloud tools, security, and continuity."},
  @{Slug="it-services-for-devonport"; Name="Devonport"; Note="Devonport teams use TassieTech for support, cloud, security, websites, and network help."},
  @{Slug="it-services-for-latrobe"; Name="Latrobe"; Note="Close to our home base, Latrobe businesses can rely on practical local technology help."},
  @{Slug="it-services-for-ulverstone"; Name="Ulverstone"; Note="Ulverstone businesses can get managed support, security guidance, and project delivery."},
  @{Slug="it-services-for-port-sorell"; Name="Port Sorell"; Note="Port Sorell businesses can simplify operations with local support and modern systems."},
  @{Slug="it-services-for-sheffield"; Name="Sheffield"; Note="Sheffield organisations can access friendly technology support without confusing language."},
  @{Slug="it-services-for-launceston"; Name="Launceston"; Note="Launceston organisations can work with TassieTech for remote support, Microsoft 365, security guidance, websites, and practical technology projects."},
  @{Slug="it-services-for-deloraine"; Name="Deloraine"; Note="Regional businesses in Deloraine deserve clear advice and dependable technology support."},
  @{Slug="it-services-for-george-town"; Name="George Town"; Note="George Town and Tamar Valley businesses can connect into TassieTech's Launceston-linked support network for devices, cloud services, websites, and security."},
  @{Slug="it-services-for-perth"; Name="Perth"; Note="Perth businesses can work with TassieTech for Launceston-linked remote support, Microsoft 365, security guidance, websites, and practical projects."},
  @{Slug="it-services-for-campbell-town"; Name="Campbell Town"; Note="Campbell Town and Midlands teams can access practical remote support for business systems, security, cloud tools, and websites."},
  @{Slug="it-services-for-st-helens"; Name="St Helens"; Note="St Helens and East Coast teams can use TassieTech for remote support, cloud systems, security advice, and practical project delivery."},
  @{Slug="it-services-for-hobart"; Name="Hobart"; Note="Hobart teams can use TassieTech for remote support, security advice, cloud systems, and project delivery across southern Tasmania."},
  @{Slug="it-services-for-new-norfolk"; Name="New Norfolk"; Note="New Norfolk and Derwent Valley teams can use TassieTech for remote support, cloud systems, security advice, and practical project delivery."},
  @{Slug="it-services-for-sorell"; Name="Sorell"; Note="Sorell and south-east Tasmanian teams can use TassieTech for remote support, security advice, cloud systems, and project delivery."},
  @{Slug="it-services-for-kingston"; Name="Kingston"; Note="Kingston businesses can work with TassieTech for Hobart-linked remote support, Microsoft 365, cyber security, websites, and practical projects."},
  @{Slug="it-services-for-huonville"; Name="Huonville"; Note="Huonville and Huon Valley teams can access remote support for business systems, security, cloud tools, websites, and continuity."}
)

foreach ($town in $towns) {
  $townFaqs = @(
    @{ Q = "Can TassieTech provide business IT support in $($town.Name)?"; A = "Yes. $($town.Name) businesses can contact TassieTech for remote-first support, project work, and planned onsite help where proximity and scheduling make sense." },
    @{ Q = "What business systems can you support for $($town.Name) teams?"; A = "We can help with Microsoft 365, SharePoint, devices, accounts, 1Password, UniFi networks, WordPress, backups, Synology NASs, remote support, cyber security, and practical technology projects." },
    @{ Q = "Should urgent issues be submitted through the form?"; A = "If operations have stopped, data may be at risk, or there is a suspected compromise, call TassieTech first. The form is useful for context, but critical incidents need faster triage." }
  )
  $townContent = @"
<section class="section">
  <div class="grid two">
    <div class="rich-text reveal">
      <span class="section-kicker">$($town.Name) IT support</span>
      <h2>Business IT support built around $($town.Name) teams.</h2>
      <p>$($town.Note) Our mission is to help local teams simplify operations, improve security, and stay productive.</p>
    </div>
    <div class="card reveal">
      <h2>Services in $($town.Name)</h2>
      <ul><li>Complete business IT support</li><li>Microsoft 365 and SharePoint help</li><li>Cyber security and backup guidance</li><li>WordPress development, care, and hosting</li><li>UniFi, phone, internet, and network support</li><li>Custom software and practical technology projects</li></ul>
    </div>
  </div>
</section>
<section class="section tight">
  <div class="service-path-grid reveal" aria-label="Related $($town.Name) IT services">
    <a href="{{root}}managed-it-support-tasmania/">Managed IT support</a>
    <a href="{{root}}microsoft-365-support-tasmania/">Microsoft 365 support</a>
    <a href="{{root}}cyber-security-tasmania/">Cyber security</a>
    <a href="{{root}}unifi-network-support-tasmania/">UniFi network support</a>
    <a href="{{root}}wordpress-care-tasmania/">WordPress care</a>
    <a href="{{root}}backup-strategy-tasmania/">Backup strategy</a>
    <a href="{{root}}individuals/">Individual IT help</a>
    <a href="{{root}}scam-recovery/">Scam recovery</a>
  </div>
</section>
$(FaqSection $townFaqs)
$(CtaPanel "We would love to work with your $($town.Name) team." "Contact TassieTech to discover how local technology support can make work easier, safer, and more reliable.")
"@
  Add-Page $town.Slug "Business IT Support $($town.Name) | TassieTech Tasmania" "Local business IT support for $($town.Name), including managed support, cyber security, Microsoft 365, websites, software, phones, internet, and networks." "$($town.Name) IT services" "Business IT Support For $($town.Name)" "$($town.Name)'s Local IT Support and Development Experts for Businesses and Individuals" $townContent "areas"
  Register-Faq $town.Slug $townFaqs
  Register-ServiceSchema $town.Slug "Business IT Support for $($town.Name)" "Local business IT support for $($town.Name), including managed support, cyber security, Microsoft 365, websites, software, phones, internet, and networks." "Business IT support" $town.Name
}

$blogCards = Render-BlogCards $BlogPosts
$blogContent = @"
<section class="section">
  <div class="section-header reveal">
    <span class="section-kicker">Insights</span>
    <h2>Practical technology advice for Tasmanian teams.</h2>
    <p>Security, device, scam, and productivity guidance.</p>
  </div>
  <div class="grid three blog-grid">
$blogCards
  </div>
</section>
$(CtaPanel "Have a technology question?" "Send us the context and we will give you practical next steps.")
"@
Add-Page "blog" "TassieTech Blog | Practical IT Advice Tasmania" "Practical IT advice from TassieTech on secure technology, business support, scam recovery, devices, and technology decisions for Tasmanian teams." "Blog" "Technology advice without the noise." "Plain-language IT guidance for Tasmanian businesses, community organisations, and individuals." $blogContent "blog"

foreach ($post in $BlogPosts) {
  $articleContent = Render-BlogArticle $post
  $postPageTitle = "$($post.title) | TassieTech"
  if ($postPageTitle.Length -gt 60) { $postPageTitle = $post.title }
  Add-Page $post.slug $postPageTitle $post.description $post.category $post.title $post.excerpt $articleContent "blog" "compact" $post.image "center 50%"
}

$contactContent = @"
<section class="section">
  <div class="contact-grid">
    <div class="reveal">
      <div class="contact-method"><div><strong>Phone</strong><span>$Phone</span></div><a class="button secondary" href="tel:0364494214">Call</a></div>
      <div class="contact-method"><div><strong>Email</strong><span>$Email</span></div><a class="button secondary" href="mailto:$Email">Email</a></div>
      <div class="contact-method"><div><strong>Office</strong><span>$Address<br>By appointment only</span></div></div>
      <div class="contact-method"><div><strong>Hours</strong><span>Monday to Friday, 9am to 5pm<br>Saturday and Sunday closed</span></div></div>
    </div>
    $(IntakeForm "" "Tell us what you need and the form will collect the right details.")
  </div>
</section>
<section class="section tight">
  <div class="next-steps-panel reveal">
    <div>
      <span class="section-kicker">What happens next</span>
      <h2>We route your enquiry by urgency and intent.</h2>
    </div>
    <div class="next-step-grid">
      <article><strong>Business support</strong><span>We check impact, users affected, and urgency.</span></article>
      <article><strong>Projects</strong><span>We review scope, timing, systems, and budget range.</span></article>
      <article><strong>Critical issues</strong><span>If operations have stopped, call $Phone first.</span></article>
    </div>
  </div>
</section>
"@
Add-Page "contact" "Contact TassieTech | Local IT Support Tasmania" "Contact TassieTech for local Tasmanian IT support, business technology help, scam recovery, managed services, and practical advice." "Contact" "Connect With TassieTech" "When you reach out, you are more than a ticket number. Speak directly with a local technology team." $contactContent "contact"

$thankYouContent = @"
<section class="section tight">
  <div class="cta-panel reveal">
    <div>
      <span class="section-kicker">Message received</span>
      <h2>Thanks for contacting TassieTech.</h2>
      <p>We have received your enquiry and will review the details. If this is urgent, call $Phone so we can triage it faster.</p>
    </div>
    <a class="button primary" href="{{root}}contact/">Back to contact</a>
  </div>
</section>
"@
Add-Page "thank-you" "Thank You for Contacting TassieTech" "Thank you for contacting TassieTech. If the issue is urgent, call the Latrobe-based team so we can triage it faster." "Thank you" "Thanks for contacting TassieTech." "We have received your enquiry." $thankYouContent "contact" "compact" "" "" $true

$careersContent = @"
<section class="section">
  <div class="grid two">
    <div class="rich-text reveal">
      <span class="section-kicker">Careers</span>
      <h2>Join a team where technical skill and care both matter.</h2>
      <p>At TassieTech, every day brings different challenges across support, security, cloud, websites, networks, and software. We value people who like solving problems and explaining technology clearly.</p>
      <p>If our work and culture resonate with you, send your resume and a short note to info@tassietech.com.au. We keep expressions of interest on file for future opportunities.</p>
    </div>
    <div class="grid">
      <article class="card reveal"><h3>Dynamic challenges</h3><p>No two days are the same. Learn, adapt, and improve real systems for local clients.</p></article>
      <article class="card reveal"><h3>Commitment to growth</h3><p>We want team members to keep developing their skills and confidence.</p></article>
      <article class="card reveal"><h3>Create lasting change</h3><p>Help Tasmanian businesses and community organisations work safer and smarter.</p></article>
    </div>
  </div>
</section>
$(CtaPanel "Want to join the TassieTech team?" "Send your resume and a short note about why our team resonates with you.")
"@
Add-Page "careers" "Careers at TassieTech | Technology Jobs Tasmania" "Join the TassieTech team. Work on meaningful technology challenges for Tasmanian businesses and communities in a friendly, reliable, professional environment." "Careers" "Join the TassieTech Team" "Partnership, reliability, friendliness, and practical technical work for Tasmanian clients." $careersContent "about"

$legalContent = @"
<section class="section">
  <div class="rich-text reveal">
    <span class="section-kicker">Managed service agreements</span>
    <h2>Terms and client resource documents.</h2>
    <p>These documents are general to TassieTech Managed Service Agreements. They may be updated as needed, with current versions made available here. If you would like update notices, contact office@tassietech.com.au.</p>
  </div>
  <div class="grid two">
    <a class="card lift reveal" href="{{root}}general-terms-and-conditions/"><h3>General Terms and Conditions</h3><p>General agreement information for managed service clients.</p></a>
    <a class="card lift reveal" href="{{root}}guaranteed-response-times/"><h3>Guaranteed Response Times</h3><p>How response priorities are understood for managed service support.</p></a>
    <a class="card lift reveal" href="{{root}}minimum-hardware-requirements/"><h3>Minimum Hardware Requirements</h3><p>Baseline expectations for supported computers, servers, networks, and software.</p></a>
    <a class="card lift reveal" href="{{root}}recommended-technology-platform/"><h3>Recommended Technology Platform</h3><p>Common tools and platforms TassieTech trusts and supports.</p></a>
  </div>
</section>
"@
Add-Page "legal" "Legal and Managed Service Terms | TassieTech" "TassieTech managed service agreement documents, general terms, response times, minimum hardware requirements, and recommended technology platform." "Legal" "Terms and Conditions" "General documents for TassieTech Managed Service Agreements." $legalContent "legal"

$hardwareContent = @"
<section class="section">
  <div class="rich-text reveal">
    <h2>Minimum Hardware Requirements</h2>
    <p>For TassieTech Managed Service Agreements, supported devices should be fit for purpose, owned by the company, and capable of running current secure software.</p>
    <h3>Computers</h3><ul><li>Less than 5 years old.</li><li>Windows 10 or newer, genuine licence.</li><li>macOS 13 Ventura or newer.</li><li>2.4 GHz processor or better.</li><li>Minimum 4GB RAM, 8GB recommended.</li><li>256GB SSD or faster storage.</li></ul>
    <h3>Servers</h3><ul><li>Windows Server 2012 or newer.</li><li>Ubuntu 20.04 or newer.</li><li>Display support for 1280 x 1024 or higher.</li></ul>
    <h3>Network and software</h3><ul><li>Networking equipment less than 5 years old.</li><li>Microsoft 365 licences or Microsoft Office 2022 or newer.</li><li>All devices must be appropriate for business use.</li></ul>
  </div>
</section>
"@
Add-Page "minimum-hardware-requirements" "Minimum Hardware Requirements | TassieTech" "Minimum hardware requirements for TassieTech managed service agreements, including computers, servers, networking equipment, software, and supported devices." "Client resources" "Minimum Hardware Requirements" "Baseline expectations for managed service devices and systems." $hardwareContent "legal"

$platformContent = @"
<section class="section">
  <div class="rich-text reveal">
    <h2>Recommended Technology Platform</h2>
    <p>The following tools represent a practical, supportable baseline for managed devices and common business workflows.</p>
    <ul><li>Windows 10 or newer, Windows Server 2012 or newer, Ubuntu 20.04 or newer, macOS 13 Ventura or newer.</li><li>Microsoft Office, LibreOffice, Outlook, Thunderbird, Microsoft Edge, Google Chrome, and Mozilla Firefox.</li><li>1Password, Dropbox, Google Drive, OneDrive, Zoom, Slack, Microsoft Teams, Google Meet.</li><li>VirtualBox, OpenVPN, 7-Zip, Splashtop Streamer, and Splashtop Anti-Virus where appropriate.</li></ul>
  </div>
</section>
"@
Add-Page "recommended-technology-platform" "Recommended Technology Platform | TassieTech" "Recommended technology platform for TassieTech clients, covering operating systems, productivity tools, browsers, security, cloud, and remote access." "Client resources" "Recommended Technology Platform" "A practical baseline of tools TassieTech trusts and supports." $platformContent "legal"

$responseContent = @"
<section class="section">
  <div class="rich-text reveal">
    <h2>Guaranteed Response Times</h2>
    <p>Managed service response priorities should be clear before something goes wrong. This page explains the intent: urgent business disruption receives priority, while lower-impact requests are scheduled sensibly.</p>
    <h3>Priority guide</h3>
    <ul><li><strong>Critical:</strong> business-wide outage, suspected compromise, or major operational disruption.</li><li><strong>High:</strong> important staff or systems blocked with no practical workaround.</li><li><strong>Normal:</strong> individual support requests, minor issues, changes, and improvements.</li><li><strong>Planned:</strong> projects, procurement, migrations, and scheduled maintenance.</li></ul>
    <p>For exact response commitments, refer to your current managed service agreement or contact TassieTech.</p>
  </div>
</section>
"@
Add-Page "guaranteed-response-times" "Guaranteed Response Times | TassieTech" "Response priority guide for TassieTech managed service support, covering critical, high, normal, and planned IT requests." "Client resources" "Guaranteed Response Times" "How TassieTech prioritises managed service support requests." $responseContent "legal"

$termsContent = @"
<section class="section">
  <div class="rich-text reveal">
    <h2>General Terms and Conditions</h2>
    <p>This page is the public location for general terms connected with TassieTech Managed Service Agreements. Agreement-specific inclusions, exclusions, response commitments, fees, and responsibilities should be read together with the signed service agreement.</p>
    <p>For the current agreement pack or update notices, contact office@tassietech.com.au.</p>
  </div>
</section>
"@
Add-Page "general-terms-and-conditions" "General Terms and Conditions | TassieTech" "General terms and conditions for TassieTech managed service agreements, including agreement scope, client responsibilities, updates, and support documents." "Client resources" "General Terms and Conditions" "Managed service agreement information for TassieTech clients." $termsContent "legal"

Add-Page "about-page" "About TassieTech | Local IT Experts Tasmania" "Meet TassieTech, a Tasmanian technology partner combining local care with professional IT, cyber security, software, web, and network expertise." "About TassieTech" "Discover TassieTech" "Where local heart meets global technology expertise." $aboutContent "about" "compact" "" "" $true

function Render-Layout {
  param($Page)

  $prefix = Get-Prefix $Page.Path
  $content = $Page.Content.Replace("{{root}}", $prefix)
  $canonical = Get-PageCanonical $Page
  $brandHref = if ($prefix -eq "") { "./" } else { $prefix }
  $title = [System.Net.WebUtility]::HtmlEncode($Page.Title)
  $description = [System.Net.WebUtility]::HtmlEncode($Page.Description)
  $active = $Page.Active
  $heroClass = if ([string]::IsNullOrWhiteSpace($Page.HeroClass)) { "" } else { " $($Page.HeroClass)" }
  $heroImage = if ([string]::IsNullOrWhiteSpace($Page.HeroImage)) { "assets/img/heroes/home.jpeg" } else { $Page.HeroImage }
  $heroPosition = if ([string]::IsNullOrWhiteSpace($Page.HeroPosition)) { "center 46%" } else { $Page.HeroPosition }
  $robotsMeta = if ($Page.NoIndex) { '<meta name="robots" content="noindex, follow">' } else { "" }
  $structuredData = if ($Page.NoIndex) {
    ""
  } else {
    (@(Get-ArticleSchema $Page; Get-HomeSchema $Page; Get-ServiceSchema $Page; Get-FaqSchema $Page; Get-PageTypeSchema $Page) | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }) -join "`n  "
  }
  $heroActions = Get-HeroActions $Page $prefix
  $heroPanel = (IntakeForm "hero-intake-panel" "" "What do you need help with?").Replace("{{root}}", $prefix)

  $navItems = @(
    @{Label="Businesses"; Href="services/"; Key="services"},
    @{Label="Individuals"; Href="individuals/"; Key="individuals"},
    @{Label="Areas"; Href="areas-we-serve/"; Key="areas"},
    @{Label="About"; Href="about/"; Key="about"},
    @{Label="Blog"; Href="blog/"; Key="blog"}
  )

  $mobileFunnelHtml = @"
<li class="mobile-call-item"><a class="mobile-call-link" href="tel:0364494214">Call $PhoneShort</a></li>
<li class="mobile-funnel-title"><a class="mobile-funnel-main" href="${prefix}contact/">Get IT Help</a></li>
<li class="mobile-funnel-item"><a href="${prefix}contact/?intent=business-support">Business IT Support</a></li>
<li class="mobile-funnel-item"><a href="${prefix}contact/?intent=personal">Personal IT Help</a></li>
<li class="mobile-funnel-item"><a href="${prefix}emergency-response/">Urgent IT Issue</a></li>
<li class="mobile-funnel-item"><a href="${prefix}contact/?intent=project">Plan a Project</a></li>
"@

  $navHtml = ($navItems | ForEach-Object {
    $href = "$prefix$($_.Href)"
    if ($_.Href -eq "") { $href = if ($prefix -eq "") { "./" } else { $prefix } }
    $class = if ($_.Key -eq $active) { ' class="active"' } else { "" }
    "<li><a$class href=""$href"">$($_.Label)</a></li>"
  }) -join "`n"
  $navHtml = "$mobileFunnelHtml`n$navHtml"

@"
<!doctype html>
<html lang="en" data-theme="light">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>$title</title>
  <meta name="description" content="$description">
  $robotsMeta
  <meta name="theme-color" content="#faf6fb">
  <link rel="canonical" href="$canonical">
  <link rel="icon" type="image/png" sizes="32x32" href="${prefix}assets/img/favicon-32.png">
  <link rel="icon" type="image/png" sizes="192x192" href="${prefix}assets/img/favicon-192.png">
  <link rel="icon" type="image/png" sizes="512x512" href="${prefix}assets/img/favicon.png">
  <link rel="apple-touch-icon" sizes="192x192" href="${prefix}assets/img/apple-touch-icon.png">
  <link rel="preload" as="image" href="${prefix}$heroImage">
  <link rel="stylesheet" href="${prefix}assets/css/styles.css">
  $structuredData
  <script>
    (function(){var t=localStorage.getItem('tt-theme');document.documentElement.dataset.theme=(t==='light'||t==='dark')?t:'light';})();
  </script>
</head>
<body>
  <a class="skip-link" href="#main">Skip to content</a>
  <header class="site-header">
    <div class="nav-shell">
      <a class="brand-link" href="$brandHref" aria-label="TassieTech home">
        <img src="${prefix}assets/img/tassietech-logo.jpg" alt="" width="68" height="43">
        <span>TassieTech</span>
      </a>
      <nav class="primary-nav" data-primary-nav aria-label="Primary navigation">
        <ul>
          $navHtml
        </ul>
      </nav>
      <div class="nav-actions">
        <a class="button secondary nav-phone" href="tel:0364494214">03 6449 4214</a>
        <details class="help-menu" data-help-menu>
          <summary class="button primary nav-help-trigger">Get IT Help</summary>
          <div class="help-menu-panel" aria-label="Choose a support path">
            <a href="${prefix}contact/?intent=business-support"><strong>Business IT Support</strong><span>Managed IT, Microsoft 365, networks, security, devices, and staff support.</span></a>
            <a href="${prefix}contact/?intent=personal"><strong>Personal IT Help</strong><span>Computers, email, internet, scams, devices, and account issues.</span></a>
            <a class="urgent" href="${prefix}emergency-response/"><strong>Urgent IT Issue</strong><span>Outages, suspected compromise, disruption, or time-sensitive problems.</span></a>
            <a href="${prefix}contact/?intent=project"><strong>Plan a Project</strong><span>Websites, migrations, cloud, backup, security, and system improvements.</span></a>
          </div>
        </details>
        <button class="theme-toggle" type="button" data-theme-toggle aria-label="Toggle colour mode"></button>
        <button class="nav-toggle" type="button" data-nav-toggle aria-label="Open navigation" aria-expanded="false"><span></span></button>
      </div>
    </div>
  </header>
  <main id="main">
    <section class="hero$heroClass" style="--hero-image:url('/$heroImage');--hero-position:$heroPosition">
      <div class="hero-grid">
        <div class="hero-copy reveal in-view">
          <span class="eyebrow">$($Page.Kicker)</span>
          <h1>$($Page.Heading)</h1>
          <p>$($Page.Intro)</p>
          <div class="hero-actions">
            $heroActions
          </div>
          <div class="hero-proof" aria-label="TassieTech strengths">
            <span>North West based</span>
            <span>Statewide remote support</span>
            <span>Security-led advice</span>
          </div>
        </div>
        $heroPanel
      </div>
    </section>
    $content
  </main>
  <footer class="site-footer">
    <div class="footer-grid">
      <div class="footer-brand">
        <img src="${prefix}assets/img/tassietech-logo.jpg" alt="" width="84" height="54" loading="lazy">
        <div>
          <h2>TassieTech</h2>
          <p>Proudly serving the North West, West Coast, East Coast, Midlands, greater Hobart, Launceston, and connected Tasmanian towns.</p>
        </div>
        <p><strong>$Phone</strong><br><a href="mailto:$Email">$Email</a><br>$Address</p>
      </div>
      <div class="footer-links">
        <div><h3>Site</h3><ul><li><a href="${prefix}about/">About</a></li><li><a href="${prefix}services/">Businesses</a></li><li><a href="${prefix}individuals/">Individuals</a></li><li><a href="${prefix}community-services/">Community Services</a></li><li><a href="${prefix}areas-we-serve/">Areas</a></li><li><a href="${prefix}blog/">Blog</a></li><li><a href="${prefix}contact/">Contact</a></li><li><a href="${prefix}legal/">Legal</a></li><li><a href="${prefix}careers/">Careers</a></li></ul></div>
        <div><h3>Business IT</h3><ul><li><a href="${prefix}business-it-support-tasmania/">Business IT Support</a></li><li><a href="${prefix}managed-it-support-tasmania/">Managed IT</a></li><li><a href="${prefix}microsoft-365-support-tasmania/">Microsoft 365</a></li><li><a href="${prefix}cyber-security-tasmania/">Cyber Security</a></li><li><a href="${prefix}backup-strategy-tasmania/">Backup Strategy</a></li><li><a href="${prefix}unifi-network-support-tasmania/">UniFi Networks</a></li></ul></div>
        <div><h3>Web and Projects</h3><ul><li><a href="${prefix}wordpress-care-tasmania/">WordPress Care</a></li><li><a href="${prefix}emergency-response/">Emergency Response</a></li><li><a href="${prefix}contact/?intent=project">Plan a Project</a></li></ul></div>
        <div><h3>Areas</h3><ul><li><a href="${prefix}areas-we-serve/">Areas We Serve</a></li><li><a href="${prefix}it-services-tasmania/">Tasmania IT Services</a></li><li><a href="${prefix}it-services-for-devonport/">Devonport</a></li><li><a href="${prefix}it-services-for-burnie/">Burnie</a></li><li><a href="${prefix}it-services-for-launceston/">Launceston</a></li><li><a href="${prefix}it-services-for-hobart/">Hobart</a></li></ul></div>
        <div><h3>Resources</h3><ul><li><a href="${prefix}legal/">Legal</a></li><li><a href="${prefix}general-terms-and-conditions/">Terms and Conditions</a></li><li><a href="${prefix}guaranteed-response-times/">Response Times</a></li><li><a href="${prefix}minimum-hardware-requirements/">Hardware Requirements</a></li><li><a href="${prefix}recommended-technology-platform/">Recommended Platform</a></li></ul></div>
        <div><h3>Contact</h3><ul><li><a href="tel:0364494214">Call $PhoneShort</a></li><li><a href="mailto:$Email">Email help desk</a></li><li><a href="${prefix}contact/">Send a message</a></li><li><a href="${prefix}scam-recovery/">Scam Recovery</a></li></ul></div>
      </div>
    </div>
    <div class="footer-bottom">Tassie Tech / Tasmanian Technology Systems - Copyright <span data-year>2026</span></div>
  </footer>
  <script src="${prefix}assets/js/main.js" defer></script>
</body>
</html>
"@
}

foreach ($page in $Pages) {
  $outDir = if ([string]::IsNullOrWhiteSpace($page.Path)) { "." } else { $page.Path.Trim("/") }
  New-Item -ItemType Directory -Force -Path $outDir | Out-Null
  Render-Layout $page | Set-Content -Path (Join-Path $outDir "index.html") -Encoding UTF8
}

New-Item -ItemType Directory -Force -Path "posts" | Out-Null
@"
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="Redirect page for the TassieTech blog archive. The current blog is available at /blog/.">
  <meta name="robots" content="noindex, follow">
  <meta http-equiv="refresh" content="0; url=../blog/">
  <link rel="canonical" href="$SiteUrl/blog/">
  <link rel="icon" type="image/png" sizes="32x32" href="../assets/img/favicon-32.png">
  <link rel="icon" type="image/png" sizes="192x192" href="../assets/img/favicon-192.png">
  <link rel="icon" type="image/png" sizes="512x512" href="../assets/img/favicon.png">
  <link rel="apple-touch-icon" sizes="192x192" href="../assets/img/apple-touch-icon.png">
  <title>TassieTech Blog Redirect</title>
</head>
<body><h1>TassieTech Blog moved</h1><p>Redirecting to <a href="../blog/">TassieTech Blog</a>.</p></body>
</html>
"@ | Set-Content -Path (Join-Path "posts" "index.html") -Encoding UTF8

$sitemapUrls = $Pages | Where-Object { -not $_.NoIndex } | ForEach-Object {
  "  <url><loc>$(Get-PageCanonical $_)</loc></url>"
}
@"
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
$($sitemapUrls -join "`n")
</urlset>
"@ | Set-Content -Path "sitemap.xml" -Encoding UTF8

@"
User-agent: *
Allow: /
Sitemap: $SiteUrl/sitemap.xml
"@ | Set-Content -Path "robots.txt" -Encoding UTF8

@"
<!doctype html>
<html lang="en">
<head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><meta http-equiv="refresh" content="0; url=./"><link rel="icon" type="image/png" sizes="32x32" href="assets/img/favicon-32.png"><link rel="icon" type="image/png" sizes="192x192" href="assets/img/favicon-192.png"><link rel="icon" type="image/png" sizes="512x512" href="assets/img/favicon.png"><link rel="apple-touch-icon" sizes="192x192" href="assets/img/apple-touch-icon.png"><title>Page not found | TassieTech</title></head>
<body><h1>Page not found</h1><p>Page not found. <a href="./">Go to TassieTech home</a>.</p></body>
</html>
"@ | Set-Content -Path "404.html" -Encoding UTF8

Write-Output "Generated $($Pages.Count) pages."

