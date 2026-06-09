(() => {
  const root = document.documentElement;
  const body = document.body;
  const themeToggle = document.querySelector("[data-theme-toggle]");
  const navToggle = document.querySelector("[data-nav-toggle]");
  const nav = document.querySelector("[data-primary-nav]");
  const helpMenu = document.querySelector("[data-help-menu]");
  const storedTheme = localStorage.getItem("tt-theme");

  if (storedTheme === "light" || storedTheme === "dark") {
    root.dataset.theme = storedTheme;
  } else {
    root.dataset.theme = "light";
  }

  const themeIcons = `
    <span class="theme-icon theme-icon-sun" aria-hidden="true">
      <svg viewBox="0 0 24 24"><path d="M12 3v2M12 19v2M4.2 4.2l1.4 1.4M18.4 18.4l1.4 1.4M3 12h2M19 12h2M4.2 19.8l1.4-1.4M18.4 5.6l1.4-1.4"/><circle cx="12" cy="12" r="4"/></svg>
    </span>
    <span class="theme-icon theme-icon-moon" aria-hidden="true">
      <svg viewBox="0 0 24 24"><path d="M20 14.4A7.4 7.4 0 0 1 9.6 4 8 8 0 1 0 20 14.4Z"/></svg>
    </span>`;

  if (themeToggle) {
    themeToggle.innerHTML = themeIcons;
  }

  const updateThemeLabel = () => {
    if (!themeToggle) return;
    const dark = root.dataset.theme === "dark";
    themeToggle.setAttribute("aria-label", dark ? "Switch to light mode" : "Switch to dark mode");
    themeToggle.classList.toggle("is-dark", dark);
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

  helpMenu?.addEventListener("click", (event) => {
    if (event.target.closest("a")) helpMenu.removeAttribute("open");
  });

  document.addEventListener("click", (event) => {
    if (!helpMenu || helpMenu.contains(event.target)) return;
    helpMenu.removeAttribute("open");
  });

  document.addEventListener("keydown", (event) => {
    if (event.key === "Escape") {
      body.classList.remove("nav-open");
      navToggle?.setAttribute("aria-expanded", "false");
      helpMenu?.removeAttribute("open");
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

  document.querySelectorAll("[data-contact-form]").forEach((form) => {
    const sections = Array.from(form.querySelectorAll("[data-contact-section]"));
    const steps = Array.from(form.querySelectorAll("[data-form-step]"));
    const indicators = Array.from(form.querySelectorAll("[data-step-indicator]"));
    const status = form.querySelector("[data-form-status]");
    const startedAt = form.querySelector("[data-form-started-at]");
    const intentField = form.querySelector("[data-contact-intent]");
    const submissionTypeField = form.querySelector("[data-submission-type]");
    const businessRequestTypeField = form.querySelector("[data-business-request-type]");
    const reviewPath = form.querySelector("[data-review-path]");
    const reviewCopy = form.querySelector("[data-review-copy]");
    const params = new URLSearchParams(window.location.search);
    let currentStep = 0;

    if (startedAt) startedAt.value = String(Date.now());
    if (status && params.get("status") === "error") {
      status.textContent = "Something went wrong. Please check the form and try again, or call us if it is urgent.";
    }

    const intentConfig = {
      project: {
        submissionType: "business",
        businessRequestType: "project",
        label: "Plan a project",
        copy: "We will review scope, timing, systems, and budget range."
      },
      "business-support": {
        submissionType: "business",
        businessRequestType: "support",
        label: "Business support",
        copy: "We will check impact, affected users, and urgency."
      },
      urgent: {
        submissionType: "business",
        businessRequestType: "support",
        urgency: "critical",
        label: "Urgent issue",
        copy: "We will treat this as time-sensitive. Call as well if operations have stopped."
      },
      personal: {
        submissionType: "individual",
        label: "Personal tech help",
        copy: "We will review the issue and point you to the safest next step."
      }
    };

    const selectRadio = (name, value) => {
      const input = form.querySelector(`input[name="${name}"][value="${value}"]`);
      if (input) input.checked = true;
      return input;
    };

    const getChosenIntent = () => {
      const selected = form.querySelector('input[name="intentChoice"]:checked');
      return selected?.value || intentField?.value || "";
    };

    const updateReview = (intent) => {
      const config = intentConfig[intent];
      if (reviewPath) reviewPath.textContent = config?.label || "Choose a support path";
      if (reviewCopy) reviewCopy.textContent = config?.copy || "We will route your enquiry to the right next step.";
    };

    const updateContactForm = () => {
      const intent = getChosenIntent();
      const config = intentConfig[intent] || {};
      const submissionType = config.submissionType || "";
      const businessRequestType = config.businessRequestType || "";

      if (intentField) intentField.value = intent;
      if (submissionTypeField) submissionTypeField.value = submissionType;
      if (businessRequestTypeField) businessRequestTypeField.value = businessRequestType;
      if (config.urgency) selectRadio("urgency", config.urgency);
      updateReview(intent);

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

    const showStep = (index) => {
      if (!steps.length) return;
      currentStep = Math.max(0, Math.min(index, steps.length - 1));
      steps.forEach((step, stepIndex) => {
        step.hidden = stepIndex !== currentStep;
      });
      indicators.forEach((indicator, indicatorIndex) => {
        indicator.classList.toggle("is-active", indicatorIndex === currentStep);
        indicator.classList.toggle("is-complete", indicatorIndex < currentStep);
      });
      form.dataset.currentStep = String(currentStep + 1);
    };

    const validateStep = (step) => {
      const controls = Array.from(step.querySelectorAll("input, select, textarea"))
        .filter((control) => !control.disabled && control.type !== "hidden");
      const invalid = controls.find((control) => !control.checkValidity());
      if (invalid) {
        invalid.reportValidity();
        return false;
      }
      return true;
    };

    const invalidControl = () => Array.from(form.querySelectorAll("input, select, textarea"))
      .find((control) => !control.disabled && control.willValidate && !control.checkValidity());

    const requestedIntent = params.get("intent");
    if (Object.prototype.hasOwnProperty.call(intentConfig, requestedIntent)) {
      selectRadio("intentChoice", requestedIntent);
      if (intentField) intentField.value = requestedIntent;
    }

    updateContactForm();
    showStep(Object.prototype.hasOwnProperty.call(intentConfig, requestedIntent) ? 1 : 0);

    form.addEventListener("change", (event) => {
      updateContactForm();
      if (event.target?.name === "intentChoice" && steps.length && currentStep === 0) {
        window.setTimeout(() => showStep(1), 120);
      }
    });

    form.querySelectorAll("[data-step-next]").forEach((button) => {
      button.addEventListener("click", () => {
        updateContactForm();
        if (!steps[currentStep] || !validateStep(steps[currentStep])) return;
        showStep(currentStep + 1);
      });
    });

    form.querySelectorAll("[data-step-prev]").forEach((button) => {
      button.addEventListener("click", () => showStep(currentStep - 1));
    });

    form.addEventListener("submit", (event) => {
      updateContactForm();
      const invalid = invalidControl();
      if (invalid) {
        event.preventDefault();
        const step = invalid.closest("[data-form-step]");
        const stepIndex = steps.indexOf(step);
        if (stepIndex >= 0) showStep(stepIndex);
        window.setTimeout(() => invalid.reportValidity(), 40);
        return;
      }

      if (status) status.textContent = "Sending your enquiry.";
    });
  });

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
