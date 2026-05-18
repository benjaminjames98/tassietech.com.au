(() => {
  const root = document.documentElement;
  const body = document.body;
  const themeToggle = document.querySelector("[data-theme-toggle]");
  const navToggle = document.querySelector("[data-nav-toggle]");
  const nav = document.querySelector("[data-primary-nav]");
  const storedTheme = localStorage.getItem("tt-theme");

  if (storedTheme === "light" || storedTheme === "dark") {
    root.dataset.theme = storedTheme;
  } else {
    root.dataset.theme = "dark";
  }

  const updateThemeLabel = () => {
    if (!themeToggle) return;
    const dark = root.dataset.theme === "dark";
    themeToggle.setAttribute("aria-label", dark ? "Switch to light mode" : "Switch to dark mode");
    themeToggle.innerHTML = dark
      ? '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 3v2M12 19v2M4.2 4.2l1.4 1.4M18.4 18.4l1.4 1.4M3 12h2M19 12h2M4.2 19.8l1.4-1.4M18.4 5.6l1.4-1.4"/><circle cx="12" cy="12" r="4"/></svg>'
      : '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M20 14.4A7.4 7.4 0 0 1 9.6 4 8 8 0 1 0 20 14.4Z"/></svg>';
  };

  updateThemeLabel();

  themeToggle?.addEventListener("click", () => {
    root.dataset.theme = root.dataset.theme === "dark" ? "light" : "dark";
    localStorage.setItem("tt-theme", root.dataset.theme);
    updateThemeLabel();
  });

  navToggle?.addEventListener("click", () => {
    const open = body.classList.toggle("nav-open");
    navToggle.setAttribute("aria-expanded", String(open));
  });

  nav?.addEventListener("click", (event) => {
    const link = event.target.closest("a");
    if (!link) return;
    body.classList.remove("nav-open");
    navToggle?.setAttribute("aria-expanded", "false");
  });

  document.addEventListener("keydown", (event) => {
    if (event.key === "Escape") {
      body.classList.remove("nav-open");
      navToggle?.setAttribute("aria-expanded", "false");
    }
  });

  const revealEls = document.querySelectorAll(".reveal");
  if ("IntersectionObserver" in window) {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add("in-view");
          observer.unobserve(entry.target);
        }
      });
    }, { threshold: 0.12 });

    revealEls.forEach((el) => observer.observe(el));
  } else {
    revealEls.forEach((el) => el.classList.add("in-view"));
  }

  const year = document.querySelector("[data-year]");
  if (year) year.textContent = String(new Date().getFullYear());

  const form = document.querySelector("[data-contact-form]");
  if (form) {
    const sections = Array.from(form.querySelectorAll("[data-contact-section]"));
    const status = form.querySelector("[data-form-status]");
    const startedAt = form.querySelector("[data-form-started-at]");
    if (startedAt) startedAt.value = String(Date.now());

    const params = new URLSearchParams(window.location.search);
    if (status && params.get("status") === "error") {
      status.textContent = "Something went wrong. Please check the form and try again, or call us if it is urgent.";
    }

    const intent = params.get("intent");
    const intentField = form.querySelector("[data-contact-intent]");
    const selectRadio = (name, value) => {
      const input = form.querySelector(`input[name="${name}"][value="${value}"]`);
      if (input) input.checked = true;
    };
    const intentConfig = {
      project: { submissionType: "business", businessRequestType: "project" },
      "business-support": { submissionType: "business", businessRequestType: "support" },
      urgent: { submissionType: "business", businessRequestType: "support", urgency: "critical" },
      personal: { submissionType: "individual" }
    };
    if (intentField && Object.prototype.hasOwnProperty.call(intentConfig, intent)) {
      intentField.value = intent;
      const config = intentConfig[intent];
      if (config.submissionType) selectRadio("submissionType", config.submissionType);
      if (config.businessRequestType) selectRadio("businessRequestType", config.businessRequestType);
      if (config.urgency) selectRadio("urgency", config.urgency);
    }

    const updateContactForm = () => {
      const data = new FormData(form);
      const submissionType = data.get("submissionType");
      const businessRequestType = data.get("businessRequestType");

      sections.forEach((section) => {
        const key = section.dataset.contactSection;
        const active =
          key === submissionType ||
          (submissionType === "business" && key === "business") ||
          (submissionType === "business" && businessRequestType === "project" && key === "business-project") ||
          (submissionType === "business" && businessRequestType === "support" && key === "business-support");

        section.hidden = !active;
        section.querySelectorAll("input, select, textarea").forEach((control) => {
          control.disabled = !active;
          if (control.hasAttribute("data-conditional-required")) {
            control.required = active;
          }
        });
      });
    };

    updateContactForm();
    form.addEventListener("change", updateContactForm);

    form.addEventListener("submit", (event) => {
      updateContactForm();
      if (!form.reportValidity()) {
        event.preventDefault();
        return;
      }

      if (status) status.textContent = "Sending your enquiry.";
    });
  }

  const riskCheck = document.querySelector("[data-risk-check]");
  if (riskCheck) {
    const options = riskCheck.querySelectorAll("input[type='checkbox']");
    const scoreEl = riskCheck.querySelector("[data-risk-score]");
    const messageEl = riskCheck.querySelector("[data-risk-message]");
    const resultEl = riskCheck.querySelector(".risk-result");
    const updateRisk = () => {
      const selected = Array.from(options).filter((input) => input.checked);
      const score = selected.reduce((sum, input) => sum + Number(input.value || 0), 0);
      const cappedScore = Math.min(score, 100);
      resultEl?.style.setProperty("--risk-score", `${cappedScore}%`);
      if (scoreEl) scoreEl.textContent = `${cappedScore}%`;
      if (!messageEl) return;
      if (score >= 70) {
        messageEl.textContent = "High priority: book a local review before a small IT problem becomes business interruption.";
      } else if (score >= 35) {
        messageEl.textContent = "Moderate priority: there are clear wins available in security, continuity, or support.";
      } else {
        messageEl.textContent = "Good shape: a quick health check can confirm what is working and where to tighten up.";
      }
    };
    options.forEach((input) => input.addEventListener("change", updateRisk));
    updateRisk();
  }
})();
