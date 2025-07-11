# Dockerfile for Ro's Famous Cookies
FROM nginx:alpine

# Copy custom nginx configuration
COPY <<EOF /etc/nginx/conf.d/default.conf
server {
    listen 80;
    server_name 0.0.0.0;
    root /usr/share/nginx/html;
    index index.html;

    # Enable gzip compression
    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

    # Cache static assets
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|eot)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;

    # Health check endpoint
    location /health {
        access_log off;
        return 200 "healthy\n";
        add_header Content-Type text/plain;
    }
}
EOF

# Create the HTML file
COPY <<EOF /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html lang=\"en\">
<head>
    <meta charset=\"UTF-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>Ro's Famous Cookies - Get Ready to Crumble 🍪</title>
    <script src=\"https://cdn.tailwindcss.com\"></script>
    <script src=\"https://code.jquery.com/jquery-3.6.0.min.js\"></script>
</head>
<body class=\"bg-gradient-to-br from-amber-50 to-orange-100 min-h-screen\">
    <!-- Hero Section -->
    <div class=\"relative overflow-hidden\">
        <div class=\"absolute inset-0 bg-gradient-to-b from-transparent to-amber-100 opacity-50\"></div>
        <nav class=\"relative z-10 p-6 backdrop-blur-md bg-white/30\">
            <div class=\"flex justify-between items-center\">
                <h1 class=\"text-3xl font-bold text-amber-900 flex items-center gap-2\">
                    <span class=\"cookie-spin text-4xl\">🍪</span>
                    Ro's Famous
                </h1>
                
                <!-- Desktop Menu -->
                <div class=\"hidden md:flex items-center gap-8\">
                    <a href=\"#\" class=\"nav-item text-amber-900 font-semibold hover:text-orange-600 transition-colors relative active\">Home</a>
                    <a href=\"#\" class=\"nav-item text-amber-900 font-semibold hover:text-orange-600 transition-colors relative\">About</a>
                    <a href=\"#\" class=\"nav-item text-amber-900 font-semibold hover:text-orange-600 transition-colors relative\">Services</a>
                    <a href=\"#\" class=\"nav-item text-amber-900 font-semibold hover:text-orange-600 transition-colors relative\">Portfolio</a>
                    <a href=\"#\" class=\"nav-item text-amber-900 font-semibold hover:text-orange-600 transition-colors relative\">Contact</a>
                    <button id=\"orderBtn\" class=\"bg-gradient-to-r from-amber-500 to-orange-600 text-white px-6 py-3 rounded-full font-bold hover:scale-110 transition-transform shadow-lg ml-4\">
                        Get Baked 🔥
                    </button>
                </div>
                
                <!-- Mobile Menu Button -->
                <button id=\"mobileMenuBtn\" class=\"md:hidden text-amber-900\">
                    <svg class=\"w-6 h-6\" fill=\"none\" stroke=\"currentColor\" viewBox=\"0 0 24 24\" xmlns=\"http://www.w3.org/2000/svg\">
                        <path stroke-linecap=\"round\" stroke-linejoin=\"round\" stroke-width=\"2\" d=\"M4 6h16M4 12h16M4 18h16\"></path>
                    </svg>
                </button>
            </div>
            
            <!-- Mobile Menu -->
            <div id=\"mobileMenu\" class=\"hidden md:hidden mt-4 pb-4\">
                <a href=\"#\" class=\"block py-2 text-amber-900 font-semibold hover:text-orange-600 transition-colors active\">Home</a>
                <a href=\"#\" class=\"block py-2 text-amber-900 font-semibold hover:text-orange-600 transition-colors\">About</a>
                <a href=\"#\" class=\"block py-2 text-amber-900 font-semibold hover:text-orange-600 transition-colors\">Services</a>
                <a href=\"#\" class=\"block py-2 text-amber-900 font-semibold hover:text-orange-600 transition-colors\">Portfolio</a>
                <a href=\"#\" class=\"block py-2 text-amber-900 font-semibold hover:text-orange-600 transition-colors\">Contact</a>
                <button id=\"orderBtnMobile\" class=\"bg-gradient-to-r from-amber-500 to-orange-600 text-white px-6 py-3 rounded-full font-bold hover:scale-110 transition-transform shadow-lg mt-4 w-full\">
                    Get Baked 🔥
                </button>
            </div>
        </nav>

        <div class=\"container mx-auto px-6 py-12 relative z-10\">
            <div class=\"text-center mb-12\">
                <h2 class=\"text-6xl md:text-8xl font-bold text-amber-900 mb-4 cookie-title\">
                    Cookies So Good,<br>They're <span class=\"text-orange-600\">Ro-tically</span> Famous
                </h2>
                <p class=\"text-xl md:text-2xl text-amber-700 mb-8\">
                    Warning: May cause uncontro-llable drooling 🤤
                </p>
                <div class=\"flex justify-center gap-4 flex-wrap\">
                    <button class=\"cookie-btn bg-amber-500 text-white px-8 py-4 rounded-full text-lg font-bold shadow-xl hover:shadow-2xl transition-all\">
                        🍪 Order Now & Get Ro-lling
                    </button>
                    <button id=\"storyBtn\" class=\"bg-white text-amber-700 px-8 py-4 rounded-full text-lg font-bold shadow-xl hover:shadow-2xl transition-all border-2 border-amber-500\">
                        📖 The Ro-mantic Story
                    </button>
                </div>
            </div>

            <div class=\"grid md:grid-cols-2 gap-8 items-center mb-16\">
                <div class=\"giant-cookie relative\">
                    <div class=\"absolute inset-0 bg-gradient-to-r from-amber-400 to-orange-500 rounded-full blur-3xl opacity-30 animate-pulse\"></div>
                    <div class=\"relative text-center text-9xl md:text-[200px] animate-bounce\">🍪</div>
                    <div class=\"drizzle absolute top-0 left-1/2 transform -translate-x-1/2 text-6xl opacity-0\">🍫</div>
                </div>
                <div class=\"space-y-6\">
                    <div class=\"feature-card bg-white rounded-3xl p-6 shadow-xl hover:shadow-2xl transition-all cursor-pointer\">
                        <h3 class=\"text-2xl font-bold text-amber-900 mb-2\">🍫 Double Chocolate Drizzle</h3>
                        <p class=\"text-amber-700\">Our secret sauce that'll make you say \"Oh Ro!\"</p>
                    </div>
                    <div class=\"feature-card bg-white rounded-3xl p-6 shadow-xl hover:shadow-2xl transition-all cursor-pointer\">
                        <h3 class=\"text-2xl font-bold text-amber-900 mb-2\">🍮 Caramel Cascade</h3>
                        <p class=\"text-amber-700\">Smooth, silky, and absolutely Ro-mantic</p>
                    </div>
                    <div class=\"feature-card bg-white rounded-3xl p-6 shadow-xl hover:shadow-2xl transition-all cursor-pointer\">
                        <h3 class=\"text-2xl font-bold text-amber-900 mb-2\">🌟 Chip Off The Ro Block</h3>
                        <p class=\"text-amber-700\">Premium chocolate chips in every bite</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Cookie Counter -->
    <div class=\"bg-gradient-to-r from-amber-600 to-orange-600 py-8 text-white\">
        <div class=\"container mx-auto px-6 text-center\">
            <h3 class=\"text-3xl font-bold mb-4\">Cookies Devoured Counter</h3>
            <div class=\"text-6xl font-bold counter\" data-target=\"69420\">0</div>
            <p class=\"text-xl mt-2\">And Ro-lling... 🎲</p>
        </div>
    </div>

    <!-- Testimonials -->
    <div class=\"container mx-auto px-6 py-16\">
        <h2 class=\"text-4xl md:text-5xl font-bold text-center text-amber-900 mb-12\">
            What People Are Saying
        </h2>
        <div class=\"grid md:grid-cols-3 gap-6\">
            <div class=\"testimonial bg-white rounded-3xl p-6 shadow-xl opacity-0\">
                <p class=\"text-xl mb-4\">\"I can't stop eating these! Send help... or more cookies!\" 🆘</p>
                <p class=\"font-bold text-amber-700\">- Cookie Monster's Cousin</p>
            </div>
            <div class=\"testimonial bg-white rounded-3xl p-6 shadow-xl opacity-0\">
                <p class=\"text-xl mb-4\">\"Ro's cookies are so good, I proposed with one instead of a ring\" 💍</p>
                <p class=\"font-bold text-amber-700\">- Hopeless Ro-mantic</p>
            </div>
            <div class=\"testimonial bg-white rounded-3xl p-6 shadow-xl opacity-0\">
                <p class=\"text-xl mb-4\">\"These cookies are my Ro-ck and Ro-ll\" 🎸</p>
                <p class=\"font-bold text-amber-700\">- Local Cookie Enthusiast</p>
            </div>
        </div>
    </div>

    <!-- Secret Recipe Section -->
    <div class=\"bg-amber-900 text-white py-16 relative overflow-hidden\">
        <div class=\"absolute inset-0 opacity-10\">
            <div class=\"text-9xl font-bold transform rotate-12\">🍪🍪🍪🍪🍪</div>
        </div>
        <div class=\"container mx-auto px-6 relative z-10 text-center\">
            <h2 class=\"text-4xl md:text-5xl font-bold mb-8\">The Secret's in the Sauce</h2>
            <button id=\"secretBtn\" class=\"bg-gradient-to-r from-orange-500 to-red-600 px-8 py-4 rounded-full text-xl font-bold hover:scale-110 transition-transform shadow-2xl\">
                🔐 Unlock Ro's Secret
            </button>
            <div id=\"secretRecipe\" class=\"mt-8 max-w-2xl mx-auto hidden\">
                <p class=\"text-2xl mb-4\">Nice try! But Ro's recipe is more protected than Fort Knox! 🏦</p>
                <p class=\"text-lg\">Just kidding... it's love, butter, and a whole lotta chocolate 💕</p>
            </div>
        </div>
    </div>

    <!-- Order Modal -->
    <div id=\"orderModal\" class=\"fixed inset-0 bg-black bg-opacity-50 z-50 hidden\">
        <div class=\"flex items-center justify-center min-h-screen p-4\">
            <div class=\"bg-white rounded-3xl p-8 max-w-md w-full shadow-2xl transform scale-0 modal-content\">
                <h3 class=\"text-3xl font-bold text-amber-900 mb-6 text-center\">Ready to Get Baked? 🔥</h3>
                <form id=\"orderForm\" class=\"space-y-4\">
                    <input type=\"text\" placeholder=\"Your Name (or Cookie Alias)\" class=\"w-full px-4 py-3 rounded-full border-2 border-amber-300 focus:border-amber-500 outline-none\">
                    <input type=\"number\" placeholder=\"How many dozens? (Minimum: ALL OF THEM)\" class=\"w-full px-4 py-3 rounded-full border-2 border-amber-300 focus:border-amber-500 outline-none\" min=\"1\">
                    <select class=\"w-full px-4 py-3 rounded-full border-2 border-amber-300 focus:border-amber-500 outline-none\">
                        <option>Extra Drizzle (+\$2)</option>
                        <option>Double Extra Drizzle (+\$4)</option>
                        <option>Swimming in Drizzle (+\$10)</option>
                        <option>Just Inject It Into My Veins (+\$20)</option>
                    </select>
                    <button type=\"submit\" class=\"w-full bg-gradient-to-r from-amber-500 to-orange-600 text-white py-4 rounded-full font-bold text-xl hover:scale-105 transition-transform\">
                        Place My Order 🍪
                    </button>
                </form>
                <button id=\"closeModal\" class=\"mt-4 text-amber-600 hover:text-amber-800 font-bold\">
                    Nah, I'll Stay Cookie-less 😢
                </button>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class=\"bg-amber-100 py-8 mt-16\">
        <div class=\"container mx-auto px-6 text-center\">
            <p class=\"text-amber-700 text-lg mb-2\">© 2024 Ro's Famous Cookies - All Rights Ro-served</p>
            <p class=\"text-amber-600\">Made with 🍪 and bad puns</p>
        </div>
    </footer>

    <style>
        .nav-item.active::after {
            content: '';
            position: absolute;
            bottom: -4px;
            left: 0;
            right: 0;
            height: 2px;
            background: currentColor;
        }
    </style>

    <script>
        \$(document).ready(function() {
            // Mobile menu toggle
            \$('#mobileMenuBtn').click(function() {
                \$('#mobileMenu').toggleClass('hidden');
            });

            // Active state for navigation
            \$('.nav-item').click(function(e) {
                e.preventDefault();
                \$('.nav-item').removeClass('active');
                \$(this).addClass('active');
            });

            // Cookie spin animation
            \$('.cookie-spin').hover(function() {
                \$(this).addClass('animate-spin');
            }, function() {
                \$(this).removeClass('animate-spin');
            });

            // Title animation
            \$('.cookie-title').hide().fadeIn(2000);

            // Feature cards hover effect
            \$('.feature-card').hover(function() {
                \$(this).animate({
                    marginLeft: '20px'
                }, 200);
            }, function() {
                \$(this).animate({
                    marginLeft: '0px'
                }, 200);
            });

            // Drizzle animation
            \$('.giant-cookie').hover(function() {
                \$('.drizzle').animate({
                    opacity: 1,
                    top: '50%'
                }, 500);
            }, function() {
                \$('.drizzle').animate({
                    opacity: 0,
                    top: '0'
                }, 500);
            });

            // Counter animation
            \$('.counter').each(function() {
                const \$this = \$(this);
                const target = parseInt(\$this.data('target'));
                let current = 0;
                const increment = target / 100;
                
                const timer = setInterval(function() {
                    current += increment;
                    \$this.text(Math.floor(current));
                    if (current >= target) {
                        clearInterval(timer);
                        \$this.text(target.toLocaleString());
                    }
                }, 20);
            });

            // Testimonials fade in on scroll
            \$(window).scroll(function() {
                \$('.testimonial').each(function(index) {
                    if (\$(this).offset().top < \$(window).scrollTop() + \$(window).height() - 100) {
                        setTimeout(() => {
                            \$(this).animate({opacity: 1}, 500);
                        }, index * 200);
                    }
                });
            });

            // Secret button
            \$('#secretBtn').click(function() {
                \$(this).fadeOut(300, function() {
                    \$('#secretRecipe').fadeIn(500);
                });
            });

            // Order modal - updated to include mobile button
            \$('#orderBtn, #orderBtnMobile, .cookie-btn').click(function() {
                \$('#orderModal').fadeIn(300);
                \$('.modal-content').animate({
                    transform: 'scale(1)'
                }, 300);
            });

            \$('#closeModal').click(function() {
                \$('.modal-content').animate({
                    transform: 'scale(0)'
                }, 300, function() {
                    \$('#orderModal').fadeOut(300);
                });
            });

            // Form submission
            \$('#orderForm').submit(function(e) {
                e.preventDefault();
                alert(\"Order placed! Ro will personally deliver your cookies while riding a unicorn 🦄\");
                \$('#closeModal').click();
            });

            // Story button
            \$('#storyBtn').click(function() {
                \$('html, body').animate({
                    scrollTop: \$('.testimonial').first().offset().top - 100
                }, 1000);
            });

            // Random cookie rain
            setInterval(function() {
                if (Math.random() > 0.7) {
                    const cookie = \$('<div class=\"fixed text-4xl pointer-events-none\">🍪</div>');
                    cookie.css({
                        left: Math.random() * \$(window).width(),
                        top: -50
                    });
                    \$('body').append(cookie);
                    cookie.animate({
                        top: \$(window).height() + 50,
                        left: '+=50'
                    }, 3000, function() {
                        \$(this).remove();
                    });
                }
            }, 2000);
        });
    </script>
</body>
</html>
EOF

# Create a simple 404 page
COPY <<EOF /usr/share/nginx/html/404.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page Not Found - Ro's Famous Cookies</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">
    <div class="text-center">
        <h1 class="text-6xl font-bold text-gray-800 mb-4">404</h1>
        <p class="text-xl text-gray-600 mb-8">Page not found</p>
        <a href="/" class="bg-blue-500 hover:bg-blue-600 text-white px-6 py-3 rounded-lg transition-colors">
            Go Home
        </a>
    </div>
</body>
</html>
EOF

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
