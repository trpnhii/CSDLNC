#!/bin/bash

# CSDLNC Setup Commands - Interactive Docker Management

echo ""
echo "=========================================="
echo "  CSDLNC - Docker Setup & Management"
echo "=========================================="
echo ""

# Check prerequisites
if ! command -v docker &> /dev/null; then
    echo "❌ ERROR: Docker not installed"
    echo "   Install from: https://www.docker.com/products/docker-desktop"
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "❌ ERROR: Docker Compose not installed"
    exit 1
fi

echo "✓ Docker and Docker Compose detected"
echo ""

# Main menu
while true; do
    echo "COMMANDS:"
    echo ""
    echo "  1) BUILD & START all services"
    echo "     → docker-compose up --build"
    echo ""
    echo "  2) START services (no rebuild)"
    echo "     → docker-compose up -d"
    echo ""
    echo "  3) STOP all services"
    echo "     → docker-compose down"
    echo ""
    echo "  4) VIEW LOGS"
    echo "     → docker-compose logs -f"
    echo ""
    echo "  5) RESTART services"
    echo "     → docker-compose restart"
    echo ""
    echo "  6) CHECK SERVICE STATUS"
    echo "     → docker-compose ps"
    echo ""
    echo "  7) ACCESS MySQL SHELL"
    echo "     → docker-compose exec mysql mysql -u root -p csdlnc"
    echo ""
    echo "  8) REMOVE EVERYTHING (full cleanup)"
    echo "     → docker-compose down -v"
    echo ""
    echo "  0) EXIT"
    echo ""
    
    read -p "Enter choice (0-8): " choice
    echo ""
    
    case $choice in
        1)
            echo "→ Running: docker-compose up --build"
            docker-compose up --build
            ;;
        2)
            echo "→ Running: docker-compose up -d"
            docker-compose up -d
            sleep 3
            echo ""
            echo "✓ Services started!"
            echo "  Frontend: http://localhost"
            echo "  Backend:  http://localhost:8797"
            ;;
        3)
            echo "→ Running: docker-compose down"
            docker-compose down
            echo "✓ Services stopped"
            ;;
        4)
            echo "→ Running: docker-compose logs -f"
            echo "   (Press Ctrl+C to exit)"
            docker-compose logs -f
            ;;
        5)
            echo "→ Running: docker-compose restart"
            docker-compose restart
            echo "✓ Services restarted"
            ;;
        6)
            echo "→ Running: docker-compose ps"
            docker-compose ps
            ;;
        7)
            echo "→ Running: docker-compose exec mysql mysql -u root -p csdlnc"
            echo "   Password: 021199"
            docker-compose exec mysql mysql -u root -p csdlnc
            ;;
        8)
            read -p "⚠️  This will delete ALL data. Continue? (y/N): " confirm
            if [[ $confirm == "y" || $confirm == "Y" ]]; then
                echo "→ Running: docker-compose down -v"
                docker-compose down -v
                echo "✓ Everything removed"
            else
                echo "⊘ Cancelled"
            fi
            ;;
        0)
            echo "Goodbye!"
            exit 0
            ;;
        *)
            echo "❌ Invalid choice"
            ;;
    esac
    
    echo ""
    read -p "Press Enter to continue..."
    echo ""
done
