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
    [string]$HeroPosition = ""
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

function Get-HeroImage {
  param([string]$Path)
  switch ($Path.Trim("/")) {
    "" { return "assets/img/heroes/home.jpeg" }
    "about" { return "assets/img/heroes/aurora-cradle.jpg" }
    "about-page" { return "assets/img/heroes/aurora-cradle.jpg" }
    "individuals" { return "assets/img/heroes/aurora-cradle.jpg" }
    "scam-recovery" { return "assets/img/heroes/scam-recovery.jpg" }
    "services" { return "assets/img/heroes/office-services.webp" }
    "community-services" { return "assets/img/heroes/community-services.jpg" }
    "emergency" { return "assets/img/heroes/office-services.webp" }
    "emergency-response" { return "assets/img/heroes/office-services.webp" }
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
    <p>From day-to-day support through to security, cloud, websites, networks, and custom software, TassieTech keeps local teams moving without the jargon.</p>
  </div>
  <div class="grid three">
    <article class="card lift reveal">
      <span class="icon">$(Get-Icon manage)</span>
      <h3>Managed IT Support</h3>
      <p>Helpdesk, monitoring, Microsoft 365, Google Workspace, procurement, networks, phones, and practical support for the systems your team relies on.</p>
      <ul><li>Local technicians</li><li>Business continuity focus</li><li>Clear advice before spend</li></ul>
    </article>
    <article class="card lift reveal">
      <span class="icon">$(Get-Icon secure)</span>
      <h3>Cyber Security</h3>
      <p>Commercial-grade protection without unnecessary complexity. We help harden devices, secure accounts, train staff, and respond quickly when risk appears.</p>
      <ul><li>Endpoint protection</li><li>Security policies</li><li>Backup and recovery planning</li></ul>
    </article>
    <article class="card lift reveal">
      <span class="icon">$(Get-Icon grow)</span>
      <h3>Technology Growth</h3>
      <p>Use technology to remove friction from operations. We help with websites, cloud platforms, automation, software, and sensible emerging technology advice.</p>
      <ul><li>Custom software</li><li>Workflow improvement</li><li>Scalable platforms</li></ul>
    </article>
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
      <h2>Not mainland support with a Tasmanian phone number.</h2>
      <p>We live and work here. Our clients are neighbours, local employers, community services, trades, retailers, clinics, schools, and growing Tasmanian businesses that need technology to be simpler.</p>
      <div class="stat-row">
        <div class="stat"><strong>98%+</strong><span>IT issue solve rate across business and individual support.</span></div>
        <div class="stat"><strong>100%</strong><span>Tasmanian team, based in the North West.</span></div>
        <div class="stat"><strong>24/7</strong><span>Managed service monitoring options for business systems.</span></div>
        <div class="stat"><strong>No fuss</strong><span>Plain-language advice, not confusing tech theatre.</span></div>
      </div>
    </div>
  </div>
</section>
"@
}

function CommunitySection {
@"
<section class="section">
  <div class="section-header center reveal">
    <span class="section-kicker">Community</span>
    <h2>Active in the business community we support.</h2>
    <p>TassieTech supports local business groups and follows recognised professional and security guidance so clients get friendly service backed by proper standards.</p>
  </div>
  <div class="logo-cloud reveal">
    <div class="logo-pill">KaLIBA</div>
    <div class="logo-pill">DCCI</div>
    <div class="logo-pill">ASD Partner</div>
    <div class="logo-pill">Australian Computer Society</div>
  </div>
</section>
"@
}

function CtaPanel {
  param([string]$Title = "Speak directly with a local tech expert.", [string]$Text = "Tell us what is happening and we will help you choose the next practical step.")
@"
<section class="section tight">
  <div class="cta-panel reveal">
    <div>
      <h2>$Title</h2>
      <p>$Text</p>
    </div>
    <div class="button-row">
      <a class="button primary" href="{{root}}contact/">Send a message</a>
      <a class="button secondary" href="tel:0364494214">Call $PhoneShort</a>
    </div>
  </div>
</section>
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
    <p>We support Devonport, Latrobe, Port Sorell, Sheffield, Forth, Ulverstone, Deloraine, Burnie, and surrounding Tasmanian communities.</p>
  </div>
  <div class="grid four">
    <a class="card lift reveal" href="{{root}}it-services-for-devonport/"><h3>Devonport</h3><p>Business IT support, Microsoft 365, security, websites, and networks.</p></a>
    <a class="card lift reveal" href="{{root}}it-services-for-latrobe/"><h3>Latrobe</h3><p>Friendly local support close to TassieTech's home base.</p></a>
    <a class="card lift reveal" href="{{root}}it-services-for-burnie/"><h3>Burnie</h3><p>Reliable technology support for busy local businesses.</p></a>
    <a class="card lift reveal" href="{{root}}it-services-for-ulverstone/"><h3>Ulverstone</h3><p>Managed support, cyber security, and practical technology projects.</p></a>
    <a class="card lift reveal" href="{{root}}it-services-for-deloraine/"><h3>Deloraine</h3><p>Clear IT advice and responsive support for regional teams.</p></a>
    <a class="card lift reveal" href="{{root}}it-services-for-port-sorell/"><h3>Port Sorell</h3><p>Local support for growing coastal businesses and organisations.</p></a>
    <a class="card lift reveal" href="{{root}}it-services-for-sheffield/"><h3>Sheffield</h3><p>Dependable technology help for small business and community teams.</p></a>
    <a class="card lift reveal" href="{{root}}it-services-tasmania/"><h3>All Tasmania</h3><p>Remote and onsite options for broader Tasmanian needs.</p></a>
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

$BlogPostsPath = Join-Path $PSScriptRoot "data/blog-posts.json"
$BlogPosts = if (Test-Path $BlogPostsPath) {
  Get-Content -Path $BlogPostsPath -Raw | ConvertFrom-Json
} else {
  @()
}

$Pages = @()

$homeContent = @"
$(ServiceCards)
$(WhyTassieTech)
<section class="section">
  <div class="section-header center reveal">
    <span class="section-kicker">Fast health check</span>
    <h2>How exposed is your technology right now?</h2>
    <p>Tick what applies. This is not a formal audit, but it shows where a local review may save time, risk, and money.</p>
  </div>
  <div class="grid two">
    <div class="card reveal" data-risk-check>
      <div class="risk-check">
        <label class="risk-option"><input type="checkbox" value="25"><span>We do not have reliable, tested backups for important data.</span></label>
        <label class="risk-option"><input type="checkbox" value="20"><span>Staff ask the same IT questions or work around recurring issues.</span></label>
        <label class="risk-option"><input type="checkbox" value="20"><span>Microsoft 365, email, or accounts are not managed centrally.</span></label>
        <label class="risk-option"><input type="checkbox" value="20"><span>We are unsure whether every device is patched and protected.</span></label>
        <label class="risk-option"><input type="checkbox" value="15"><span>We rely on one person who knows how everything is set up.</span></label>
        <div class="risk-result"><strong data-risk-score>0%</strong><p data-risk-message></p></div>
      </div>
    </div>
    <div class="card reveal">
      <span class="icon">$(Get-Icon secure)</span>
      <h3>Turn uncertainty into a practical plan.</h3>
      <p>We can review your setup, explain the risks in normal language, and prioritise the fixes that actually matter. No scare tactics, no over-selling, just a clear path forward.</p>
      <div class="button-row">
        <a class="button primary" href="{{root}}contact/">Book a review</a>
        <a class="button secondary" href="{{root}}services/">Explore services</a>
      </div>
    </div>
  </div>
</section>
$(AreasGrid)
$(CommunitySection)
$(CtaPanel "Let's discuss your technology today." "Whether you need managed IT, urgent help, scam recovery, or a smarter way to grow, you can speak directly with a Tasmanian team.")
"@

Add-Page "" "Computer Support and IT Services Tasmania | TassieTech" "Local Tasmanian IT support for businesses and individuals. Managed IT, cyber security, scam recovery, cloud, websites, networks, and practical technology advice." "Friendly. Professional. Reliable." "IT Support in Tasmania" "Local IT experts who make technology simple for Tasmanian businesses, community organisations, and individuals." $homeContent "home" ""

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
    <h2>Computer, email, internet, and security help without the run-around.</h2>
    <p>If your device, email, Wi-Fi, router, antivirus, or software is causing stress, talk to a local technician who can explain the fix clearly.</p>
  </div>
  <div class="grid three">
    <article class="card lift reveal"><span class="icon">$(Get-Icon help)</span><h3>Computers and laptops</h3><p>Slow devices, setup, repairs, data transfer, troubleshooting, and practical advice before you spend money.</p></article>
    <article class="card lift reveal"><span class="icon">$(Get-Icon cloud)</span><h3>Email and accounts</h3><p>Email setup, password issues, Microsoft, Google, phone sync, and account security guidance.</p></article>
    <article class="card lift reveal"><span class="icon">$(Get-Icon secure)</span><h3>Internet and security</h3><p>Router setup, Wi-Fi issues, malware scans, antivirus, scam checks, and safer everyday technology use.</p></article>
  </div>
</section>
<section class="feature-band alt">
  <div class="section">
    <div class="grid two">
      <div class="reveal"><span class="section-kicker">No fix, no fee</span><h2>Honest local help for individuals.</h2><p>We aim to solve problems quickly and respectfully. You will understand what is happening, what it costs, and what choices you have.</p></div>
      <div class="card reveal"><h3>Why people choose TassieTech</h3><ul><li>98%+ solve rate across IT fields.</li><li>Friendly technicians who explain things clearly.</li><li>Local team, not a mainland call centre.</li><li>Business-grade experience applied to everyday tech problems.</li></ul></div>
    </div>
  </div>
</section>
$(CtaPanel "Need an IT issue fixed?" "Call TassieTech today or send a quick message and we will point you in the right direction.")
"@
Add-Page "individuals" "General IT Support Tasmania | TassieTech Individuals" "Computer repairs, laptop help, email setup, internet and router support, antivirus, malware scans, and friendly local IT support in Tasmania." "For individuals" "Have an IT issue and need someone to fix it?" "Call TassieTech for friendly, local support with computers, laptops, email, internet, security, and everyday technology problems." $individualContent "individuals"

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

$servicesContent = @"
$(ServiceCards)
<section class="feature-band">
  <div class="section">
    <div class="section-header reveal">
      <span class="section-kicker">Business services</span>
      <h2>Everything a local business needs from IT.</h2>
      <p>Choose focused help or a managed partnership. We can support your team, your cloud systems, your websites, your phones, your network, and your security posture.</p>
    </div>
    <div class="grid three">
      <article class="price-card reveal"><strong>Support</strong><span>Responsive helpdesk and troubleshooting for everyday business technology.</span></article>
      <article class="price-card featured reveal"><strong>Managed</strong><span>Monitoring, maintenance, security, advice, and recurring support for business continuity.</span></article>
      <article class="price-card reveal"><strong>Project</strong><span>Cloud migrations, network upgrades, websites, custom software, procurement, and automation.</span></article>
    </div>
  </div>
</section>
$(CtaPanel "Get business IT under control." "Tell us what is slowing your team down. We will help you choose the most practical path.")
"@
Add-Page "services" "Business IT Services Tasmania | Managed Support, Security and Growth" "Managed IT support, cyber security, Microsoft and Google management, cloud hosting, websites, networks, VOIP, custom software, and local technology consulting in Tasmania." "Businesses" "Business IT Services in Tasmania" "Managed support, security, consulting, cloud, websites, networks, phones, and software from a Tasmanian team." $servicesContent "services"

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
Add-Page "community-services" "IT Support for Community Services Tasmania | TassieTech" "Hassle-free IT support for Tasmanian community services organisations, including Microsoft 365, secure documents, onboarding, helpdesk, backup, and cyber security." "Community services" "Hassle-Free IT for Community Services Businesses" "Let TassieTech handle your IT so you can focus on the people and communities you serve." $communityContent "services"

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
Add-Page "emergency" "Emergency IT Response Tasmania | TassieTech" "Urgent local IT help for business outages, suspected compromises, email failures, internet problems, device issues, and security incidents in Tasmania." "Emergency response" "Urgent IT help when business stops." "Fast triage, containment, and recovery support from a local Tasmanian technology team." $emergencyContent "services"

$areasContent = @"
<section class="section media-split">
  <div class="area-map reveal" aria-label="Map of Tasmania showing TassieTech service areas">
    <svg class="tasmania-svg" viewBox="0 0 420 430" role="img" aria-labelledby="tas-title tas-desc">
      <title id="tas-title">Tasmania service map</title>
      <desc id="tas-desc">A recognisable Tasmania map with service markers across Burnie, Ulverstone, Devonport, Port Sorell, Latrobe, Sheffield, and Deloraine.</desc>
      <defs>
        <linearGradient id="tas-gradient" x1="86" y1="42" x2="334" y2="372" gradientUnits="userSpaceOnUse">
          <stop offset="0" style="stop-color: var(--brand-strong)"/>
          <stop offset="0.56" style="stop-color: var(--brand)"/>
          <stop offset="1" style="stop-color: var(--accent)"/>
        </linearGradient>
      </defs>
      <path class="tas-shore" d="M205 22c38 9 79 20 99 54 17 30 9 65 32 94 19 25 45 45 43 80-3 43-50 58-70 91-24 40-63 60-111 49-31-7-54-30-86-34-35-5-64-19-74-55-8-30 8-58 0-88-11-41-17-82 13-116 20-23 52-25 78-43 24-17 42-40 76-32Z"/>
      <path class="tas-main" d="M201 34c35 7 76 17 95 49 17 28 6 61 27 91 17 24 47 45 43 76-4 34-44 51-66 78-24 29-56 54-98 47-33-5-54-28-83-33-33-6-58-18-67-49-8-26 8-52 1-80-10-39-19-74 10-105 20-22 51-20 76-38 22-15 35-44 62-36Z"/>
      <path class="tas-route" d="M114 148 C139 136 158 135 180 136 S222 138 242 134 C263 130 283 129 304 126"/>
      <g class="tas-pin" style="animation-delay:.1s" transform="translate(116 149)"><circle r="13"/><circle r="5"/><text x="-51" y="-15">Burnie</text></g>
      <g class="tas-pin" style="animation-delay:.35s" transform="translate(169 137)"><circle r="13"/><circle r="5"/><text x="-42" y="-17">Ulverstone</text></g>
      <g class="tas-pin" style="animation-delay:.6s" transform="translate(213 137)"><circle r="13"/><circle r="5"/><text x="12" y="-13">Devonport</text></g>
      <g class="tas-pin" style="animation-delay:.85s" transform="translate(258 134)"><circle r="13"/><circle r="5"/><text x="15" y="4">Port Sorell</text></g>
      <g class="tas-pin" style="animation-delay:1.1s" transform="translate(226 170)"><circle r="13"/><circle r="5"/><text x="16" y="22">Latrobe</text></g>
      <g class="tas-pin" style="animation-delay:1.35s" transform="translate(182 207)"><circle r="13"/><circle r="5"/><text x="-62" y="26">Sheffield</text></g>
      <g class="tas-pin" style="animation-delay:1.6s" transform="translate(143 252)"><circle r="13"/><circle r="5"/><text x="-65" y="26">Deloraine</text></g>
    </svg>
    <div class="map-legend" aria-label="Service area towns">
      <span>Burnie</span><span>Ulverstone</span><span>Devonport</span><span>Port Sorell</span><span>Latrobe</span><span>Sheffield</span><span>Deloraine</span>
    </div>
  </div>
  <div class="reveal">
    <span class="section-kicker">Local coverage</span>
    <h2>North West Tasmania and remote support beyond.</h2>
    <p>We provide onsite and remote support across key Tasmanian communities, with practical options for businesses that need reliable service without waiting on mainland providers.</p>
    <div class="button-row"><a class="button primary" href="{{root}}contact/">Ask about your area</a></div>
  </div>
</section>
$(AreasGrid)
"@
Add-Page "areas-we-serve" "Areas We Serve | IT Services Tasmania | TassieTech" "TassieTech serves Devonport, Latrobe, Port Sorell, Sheffield, Ulverstone, Deloraine, Burnie, and broader Tasmania with local IT support." "Areas we serve" "IT Services Across Tasmania" "Local technology support for Tasmanian businesses, organisations, and individuals." $areasContent "areas"
Add-Page "it-services-tasmania" "IT Services Tasmania | TassieTech" "Tasmanian IT services for businesses and individuals. Local support across Devonport, Latrobe, Burnie, Ulverstone, Deloraine, Port Sorell, Sheffield, and beyond." "Tasmania" "IT Services Across Tasmania" "Local technology support for Tasmanian businesses, organisations, and individuals." $areasContent "areas"

$towns = @(
  @{Slug="it-services-for-burnie"; Name="Burnie"; Note="Burnie's busy business community needs reliable systems, secure accounts, and responsive support."},
  @{Slug="it-services-for-latrobe"; Name="Latrobe"; Note="Close to our home base, Latrobe businesses can rely on practical local technology help."},
  @{Slug="it-services-for-deloraine"; Name="Deloraine"; Note="Regional businesses in Deloraine deserve clear advice and dependable technology support."},
  @{Slug="it-services-for-devonport"; Name="Devonport"; Note="Devonport teams use TassieTech for support, cloud, security, websites, and network help."},
  @{Slug="it-services-for-port-sorell"; Name="Port Sorell"; Note="Port Sorell businesses can simplify operations with local support and modern systems."},
  @{Slug="it-services-for-ulverstone"; Name="Ulverstone"; Note="Ulverstone businesses can get managed support, security guidance, and project delivery."},
  @{Slug="it-services-for-sheffield"; Name="Sheffield"; Note="Sheffield organisations can access friendly technology support without confusing language."}
)

foreach ($town in $towns) {
  $townContent = @"
<section class="section">
  <div class="grid two">
    <div class="rich-text reveal">
      <span class="section-kicker">$($town.Name) IT support</span>
      <h2>Technology support built around $($town.Name) businesses.</h2>
      <p>$($town.Note) Our mission is to help local teams simplify operations, improve security, and stay productive.</p>
      <p>From business software and hardware support through to websites, cloud services, custom software, network support, phone systems, and practical technology advice, TassieTech helps local businesses move forward with confidence.</p>
    </div>
    <div class="card reveal">
      <h3>Services in $($town.Name)</h3>
      <ul><li>Complete business IT support</li><li>Simplified IT consultation</li><li>Custom software development</li><li>Website development and hosting</li><li>Phone, internet, and network support</li><li>Cyber security and backup guidance</li></ul>
    </div>
  </div>
</section>
$(ServiceCards)
$(CtaPanel "We would love to work with your $($town.Name) team." "Contact TassieTech to discover how local technology support can make work easier, safer, and more reliable.")
"@
  Add-Page $town.Slug "IT Services for $($town.Name) | TassieTech Tasmania" "Local IT services for $($town.Name) businesses, including managed support, cyber security, Microsoft 365, websites, custom software, phone, internet, and network help." "$($town.Name) IT services" "IT Services For $($town.Name)" "Empower your business with $($town.Name)'s local IT support and development experts." $townContent "areas"
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
  Add-Page $post.slug "$($post.title) | TassieTech" $post.description $post.category $post.title $post.excerpt $articleContent "blog" "compact" $post.image "center 50%"
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
    <form class="form-card reveal" data-contact-form>
      <div class="field"><label for="name">Name*</label><input id="name" name="name" required autocomplete="name"></div>
      <div class="field"><label for="business">Business</label><input id="business" name="business" autocomplete="organization"></div>
      <div class="field"><label for="email">Email*</label><input id="email" name="email" type="email" required autocomplete="email"></div>
      <div class="field"><label for="message">Message</label><textarea id="message" name="message" placeholder="What can we help with?"></textarea></div>
      <button class="button primary" type="submit">Send enquiry</button>
      <p data-form-status aria-live="polite"></p>
    </form>
  </div>
</section>
"@
Add-Page "contact" "Contact TassieTech | Local IT Support Tasmania" "Contact TassieTech for local Tasmanian IT support, business technology help, scam recovery, managed services, and practical advice." "Contact" "Connect With TassieTech" "When you reach out, you are more than a ticket number. Speak directly with a local technology team." $contactContent "contact"

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
Add-Page "recommended-technology-platform" "Recommended Technology Platform | TassieTech" "Recommended technology platform for TassieTech managed service clients, including operating systems, productivity tools, browsers, security, cloud, and remote access tools." "Client resources" "Recommended Technology Platform" "A practical baseline of tools TassieTech trusts and supports." $platformContent "legal"

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
Add-Page "general-terms-and-conditions" "General Terms and Conditions | TassieTech" "General terms and conditions location for TassieTech managed service agreements and client resources." "Client resources" "General Terms and Conditions" "Managed service agreement information for TassieTech clients." $termsContent "legal"

Add-Page "about-page" "About TassieTech | Local IT Experts Tasmania" "Meet TassieTech, a Tasmanian technology partner combining local care with professional IT, cyber security, software, web, and network expertise." "About TassieTech" "Discover TassieTech" "Where local heart meets global technology expertise." $aboutContent "about"

function Render-Layout {
  param($Page)

  $prefix = Get-Prefix $Page.Path
  $content = $Page.Content.Replace("{{root}}", $prefix)
  $canonical = Get-Canonical $Page.Path
  $brandHref = if ($prefix -eq "") { "./" } else { $prefix }
  $title = [System.Net.WebUtility]::HtmlEncode($Page.Title)
  $description = [System.Net.WebUtility]::HtmlEncode($Page.Description)
  $active = $Page.Active
  $heroClass = if ([string]::IsNullOrWhiteSpace($Page.HeroClass)) { "" } else { " $($Page.HeroClass)" }
  $heroImage = if ([string]::IsNullOrWhiteSpace($Page.HeroImage)) { "assets/img/heroes/home.jpeg" } else { $Page.HeroImage }
  $heroPosition = if ([string]::IsNullOrWhiteSpace($Page.HeroPosition)) { "center 46%" } else { $Page.HeroPosition }
  $articleSchema = Get-ArticleSchema $Page

  $navItems = @(
    @{Label="Home"; Href=""; Key="home"},
    @{Label="About"; Href="about/"; Key="about"},
    @{Label="Individuals"; Href="individuals/"; Key="individuals"},
    @{Label="Businesses"; Href="services/"; Key="services"},
    @{Label="Areas"; Href="areas-we-serve/"; Key="areas"},
    @{Label="Blog"; Href="blog/"; Key="blog"},
    @{Label="Contact"; Href="contact/"; Key="contact"}
  )

  $navHtml = ($navItems | ForEach-Object {
    $href = "$prefix$($_.Href)"
    if ($_.Href -eq "") { $href = if ($prefix -eq "") { "./" } else { $prefix } }
    $class = if ($_.Key -eq $active) { ' class="active"' } else { "" }
    "<li><a$class href=""$href"">$($_.Label)</a></li>"
  }) -join "`n"

@"
<!doctype html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>$title</title>
  <meta name="description" content="$description">
  <meta name="theme-color" content="#0b0810">
  <link rel="canonical" href="$canonical">
  <link rel="preload" as="image" href="${prefix}$heroImage">
  <link rel="stylesheet" href="${prefix}assets/css/styles.css">
  $articleSchema
  <script>
    (function(){var t=localStorage.getItem('tt-theme');document.documentElement.dataset.theme=(t==='light'||t==='dark')?t:'dark';})();
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
        <a class="button secondary nav-cta" href="tel:0364494214">Call $PhoneShort</a>
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
            <a class="button primary" href="${prefix}contact/">Speak to a specialist</a>
            <a class="button secondary" href="tel:0364494214">Call $PhoneShort</a>
          </div>
          <div class="hero-proof" aria-label="TassieTech strengths">
            <span>North West based</span>
            <span>Statewide remote support</span>
            <span>Security-led advice</span>
          </div>
        </div>
        <div class="hero-panel reveal in-view" aria-label="Service signals">
          <div class="signal-card"><span class="signal-dot"></span><div><strong>North West based</strong><span>Local technicians with remote support available statewide</span></div><b>Local</b></div>
          <div class="signal-card warning"><span class="signal-dot"></span><div><strong>Security first</strong><span>Practical guidance aligned with ASD and ACSC advice</span></div><b>ASD</b></div>
          <div class="signal-card"><span class="signal-dot"></span><div><strong>Service Range</strong><span>Devices, networks, security, cloud, websites, and recovery support</span></div><b>Range</b></div>
        </div>
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
          <p>Proudly serving Devonport, Latrobe, Port Sorell, Sheffield, Forth, Ulverstone, Deloraine, Burnie, and everywhere in between.</p>
        </div>
        <p><strong>$Phone</strong><br><a href="mailto:$Email">$Email</a><br>$Address</p>
      </div>
      <div class="footer-links">
        <div><h3>Site</h3><ul><li><a href="${prefix}about/">About</a></li><li><a href="${prefix}services/">Businesses</a></li><li><a href="${prefix}individuals/">Individuals</a></li><li><a href="${prefix}blog/">Blog</a></li></ul></div>
        <div><h3>Services</h3><ul><li><a href="${prefix}scam-recovery/">Scam Recovery</a></li><li><a href="${prefix}community-services/">Community Services</a></li><li><a href="${prefix}emergency-response/">Emergency Response</a></li><li><a href="${prefix}areas-we-serve/">Areas We Serve</a></li></ul></div>
        <div><h3>Resources</h3><ul><li><a href="${prefix}legal/">Legal</a></li><li><a href="${prefix}minimum-hardware-requirements/">Minimum Hardware</a></li><li><a href="${prefix}recommended-technology-platform/">Recommended Platform</a></li><li><a href="${prefix}careers/">Careers</a></li></ul></div>
        <div><h3>Contact</h3><ul><li><a href="tel:0364494214">Call $PhoneShort</a></li><li><a href="mailto:$Email">Email help desk</a></li><li><a href="${prefix}contact/">Send a message</a></li></ul></div>
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
  <meta name="robots" content="noindex, follow">
  <meta http-equiv="refresh" content="0; url=../blog/">
  <link rel="canonical" href="$SiteUrl/blog/">
  <title>TassieTech Blog</title>
</head>
<body><p>Redirecting to <a href="../blog/">TassieTech Blog</a>.</p></body>
</html>
"@ | Set-Content -Path (Join-Path "posts" "index.html") -Encoding UTF8

$sitemapUrls = $Pages | ForEach-Object {
  "  <url><loc>$(Get-Canonical $_.Path)</loc></url>"
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
<head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><meta http-equiv="refresh" content="0; url=./"><title>Page not found | TassieTech</title></head>
<body><p>Page not found. <a href="./">Go to TassieTech home</a>.</p></body>
</html>
"@ | Set-Content -Path "404.html" -Encoding UTF8

Write-Output "Generated $($Pages.Count) pages."
